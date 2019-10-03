class TransactionController < ApplicationController

    def create 
        user = User.find_by(username:params["username"])
        stock = Stock.find_by(ticker_symbol:params["ticker"])
        trans = Transaction.new(stock_id:stock.id,user_id:user.id,bought:params["quantity"].to_i,amount_paid:(params["quantity"].to_i * stock.current))
        user.update(balance:user.balance-=(params["quantity"].to_i * stock.current))
        for index in 1..params["quantity"].to_i do
            UserStock.create(user_id:user.id,stock_id:stock.id)
        end 

        if trans.save 
            render json: {
                balance: user.balance,
                transactions: create_transaction_arr(user.transactions),
                stocks: create_stock_arr(user.user_stocks)
            }
        else
            render json:{
                error:"we couldn't process your transaction at the time, try again later"
            }
        end
    end 

    def sell
        user = User.find_by(id:params["username"])
        stock = Stock.find_by(ticker_symbol:params["ticker"])
        userstock = UserStock.find_by(user_id:user.id,stock_id:stock.id)

        if(userstock.delete)
            render json: user.user_stocks
        else
            render json: {error:"something went wrong with selling"}
        end
    end

    # def generate_stock_object(stocks)
    #     obj = {}
    #     stocks.each do |user_stock|
    #         stock = Stock.find(user_stock.stock_id)
    #         if obj[stock]

    # end

end
