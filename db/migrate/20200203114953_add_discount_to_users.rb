class AddDiscountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :discount_sw, :boolean, default: false
    add_column :users, :number, :integer, default: 0
    add_column :users, :discount_price, :integer, default: 0
  end
end
