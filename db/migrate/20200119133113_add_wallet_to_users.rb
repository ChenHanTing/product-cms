class AddWalletToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :wallet, :integer, default: 2000000
  end
end
