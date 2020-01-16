class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.integer :market_price
      t.integer :original_price
      t.integer :number
      t.integer :status, default: 0
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
