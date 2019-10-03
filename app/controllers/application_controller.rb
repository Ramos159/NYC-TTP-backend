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
  
  end