class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email
    validates_uniqueness_of :username
    has_many :user_stocks
    has_many :stocks, through: :user_stocks
    has_many :transactions  
end
