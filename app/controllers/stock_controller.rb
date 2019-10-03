class StockController < ApplicationController
    
    def get_stock
        stock = Stock.find_by(ticker_symbol:params[:ticker])

        if stock 
            render json: stock
        else 
            stock = create_stock(params[:ticker])
            render json: stock
        end
    end

end 