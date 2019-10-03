class UserStockSerializer < ActiveModel::Serializer
  attributes :id, :stock
  belongs_to :stock
end
