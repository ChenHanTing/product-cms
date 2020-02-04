class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      # price_discount        ：滿額優惠
      # p_number              ：滿額優惠限制張數
      # d_number              ：免運費優惠限制張數
      # p_switch              ：開啟/關閉滿額優惠功能
      # d_switch              ：開啟/關閉免運費優惠功能
      # quota                 ：滿額優惠所需價錢低標（quota：滿額）
      # free_delivery_quota   ：滿額優惠所需價錢低標（quota：滿額）

      t.integer :price_discount, default: 0
      t.integer :p_number, default: 0
      t.integer :d_number, default: 0
      t.boolean :p_switch, default: false
      t.boolean :d_switch, default: false
      t.integer :quota, default: 0
      t.integer :free_delivery_quota, default: 0
      t.references :user
      t.references :order
      t.references :product

      t.timestamps
    end
  end
end
