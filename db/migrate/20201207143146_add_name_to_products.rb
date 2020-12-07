class AddNameToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :note, :string
    add_column :orders, :email, :string
  end
end
