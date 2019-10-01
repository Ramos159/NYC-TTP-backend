class UserController < ApplicationController

    def create
      user = User.new(
        username:params["Username"],
        password:params["Password"],
        email:params["Email"],
      )
  
      if user.save
        token = encode_token(user)
        render json: {
          username:user.username,
          balance: user.balance,
          transactions: user.transactions,
          stocks: user.user_stocks
          token: token
        }
          else
              render json: {errors: user.errors.full_messages}
          end
    end
  
  end