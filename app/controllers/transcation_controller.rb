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
