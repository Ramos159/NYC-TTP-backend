class ApplicationController < ActionController::API

  def get_auth_header
    request.headers["Authorization"]
  end

  def decode_token
    begin
      JWT.decode(get_auth_header, "normally_would_hide_this")[0]["user_id"]
    rescue
      nil
    end

  end
  
  def encode_token(user)
      JWT.encode({user_id: user.id}, "normally_would_hide_this")
  end
  
  def session_user
    User.find_by(id: decode_token)
  end

  def create_stock(ticker)
    require'rest-client'
    resp = RestClient.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{ticker}&apikey=L8JH3L90BGFPKX1S")
    resp_json = JSON.parse(resp)
    good_stuff = resp_json["Global Quote"]

    resp2 = RestClient.get("http://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=#{ticker}&apikey=L8JH3L90BGFPKX1S")
    resp2_json = JSON.parse(resp2)
    good_stuff2 = resp2_json["bestMatches"][0]

    if resp_json["Note"] || resp2_json["Note"]
      return {
        error:"Alpha Vantage API rate limit was hit, that means no new stock info for today. sorry!"
      }
    elsif resp_json["Error Message"] || resp2_json["Error Message"] 
      return {
        error:"Most Likely a backend failre or non-existent ticker symbol was searched for, please try again"
      }
    else
    stock = Stock.create(ticker_symbol:good_stuff["01. symbol"],open:good_stuff["02. open"],current:good_stuff["05. price"],name:good_stuff2["2. name"])
    return stock
    end
  end
  
  end