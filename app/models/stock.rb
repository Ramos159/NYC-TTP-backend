class Stock < ApplicationRecord
    has_many :userstocks
    validates_uniqueness_of :ticker_symbol
end
