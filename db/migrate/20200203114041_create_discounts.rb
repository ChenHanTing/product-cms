class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.string :number
      t.string :price
      t.references :user

      t.timestamps
    end
  end
end
