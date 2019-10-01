class TranscationController < ApplicationController

    def create 
        user = User.find(params["UserID"])
        stock = Stock.find_by(ticker_symbol:params["Ticker"])

        if stock
            trans = Transaction.new(stock_id:stock.id,user_id:user.id,bought:params["SharesBought"],amount:params["AmountPaid"])
        else 
            stock = create_stock(params["Ticker"])
            trans = Transaction.new(stock_id:stock.id,user_id:user.id,bought:params["SharesBought"],amount:params["AmountPaid"])
        end 

        for index in 1..params["SharesBought"] do
            UserStock.create(user_id:params["UserID"],stock_id:stock.id)
        end 

        render json: user.transactions
    end 

    def create_stock
        require'rest-client'
        resp = RestClient.get(`https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{params["Ticker"]}apikey=60A52VC1JPUTDL0G`)
        resp_json = JSON.parse(resp)
        good_stuff = resp_json["Global Quote"]

        resp2 = RestClient.get(`https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=#{params["Ticker"]}&apikey=60A52VC1JPUTDL0G`)
        good_stuff2 = resp2["best matches"][0]

        stock = Stock.new(symbol:good_stuff["01. symbol"],open:goodstuff["02. open"],current:goodstuff["05. price"],name:good_stuff2["2. name"])
        return stock
    end

    def sell
        user = User.find_by(id:params["UserID"])
        stock = Stock.find_by(ticker_symbol:params["TickerSymbol"])
        userstock = UserStock.find_by(user_id:user.id,stock_id:stock.id))

        if(userstock.delete)
            render json: user.user_stocks
        else
            render json: {"Error":"something went wrong with selling"}
    end

end
