class CreateUserStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_stocks do |t|
      t.references :user, foreign_key: true
      t.references :stock, foreign_Key: true
      # t.boolean :sold

      t.timestamps
    end
  end
end
