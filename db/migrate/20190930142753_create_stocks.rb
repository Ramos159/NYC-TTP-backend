class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :ticker_symbol
      t.integer :open
      t.integer :current

      t.timestamps
    end
  end
end
