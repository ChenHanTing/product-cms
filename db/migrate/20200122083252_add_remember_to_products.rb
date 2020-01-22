class AddRememberToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :remember, :boolean, default: false
  end
end
