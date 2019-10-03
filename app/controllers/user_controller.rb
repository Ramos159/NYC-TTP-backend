class UserController < ApplicationController

    def create
      user = User.new(
        username:params["username"],
        password:params["password"],
        email:params["email"],
      )
      puts user
      if user.save
        token = encode_token(user)
        render json: {
          username:user.username,
          balance: user.balance,
          transactions: user.transactions,
          stocks: user.user_stocks,
          token: token
        }
          else
              render json: {errors: user.errors.full_messages}
          end
    end
  
  end