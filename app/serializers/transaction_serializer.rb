class TransactionSerializer < ActiveModel::Serializer
  attributes :amount_paid,:bought, :stock, :created_at
  belongs_to :stock
end