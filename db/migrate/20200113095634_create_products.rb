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

      # 使用 cookie
      t.boolean :remember, :boolean, default: false

      # 判斷產品是否為禮物
      t.boolean :gift, default: false

      # quantity_discount     ：買多優惠(新台幣)
      # q_switch              ：開啟/關閉買多優惠功能
      # quantity              ：買多優惠所需數量低標
      # q_number              ：買多優惠限制張數

      t.integer :quantity_discount, default: 0
      t.boolean :q_switch, default: false
      t.integer :quantity, default: 0
      t.integer :q_number, default: 0

      t.timestamps
    end
  end
end
