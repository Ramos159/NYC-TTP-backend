class AuthController < ApplicationController

    def login
      update_stock
      user = User.find_by(email: params["email"])
      if user && user.authenticate(params["password"])
        token = encode_token(user)
        render json: {
            username:user.username,
            balance: user.balance,
            transactions: user.transactions,
            stocks: user.user_stocks,
            token: token
          }
      else
        render json: {errors: "You entered wrong username or password!"}
      end
  
    end

    def update_stock
        Stock.all.each do |stock|
            resp = RestClient.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{stock.ticker_symbol}&apikey=60A52VC1JPUTDL0G")
            resp_json = JSON.parse(resp)
            good_stuff = resp_json["Global Quote"]
            # check if i get rate limited
            if resp_json["Note"]
            else
            stock.update(open:good_stuff["02. open"],current:good_stuff["05. price"])
            end
        end
    end
  
    def autologin
      user = session_user
      update_stock
      if user
        render json: {
            username:user.username,
            balance: user.balance,
            transactions: user.transactions,
            stocks: user.user_stocks,
          }
      else
        render json: {errors: "Auto Login did not work! please log in manually"}
      end
    end
  
  
  end