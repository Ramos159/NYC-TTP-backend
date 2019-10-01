class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :stock, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :bought
      t.integer :amount_paid

      t.timestamps
    end
  end
end
