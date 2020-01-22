class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :number
      t.string :code
      t.integer :price
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
