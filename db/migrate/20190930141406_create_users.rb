class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.integer :balance, default:5000
      t.string :email
      # t.boolean :activated

      # t.timestamps
    end
  end
end
