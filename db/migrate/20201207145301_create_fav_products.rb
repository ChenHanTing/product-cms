class CreateFavProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :fav_products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :note

      t.timestamps
    end
  end
end
