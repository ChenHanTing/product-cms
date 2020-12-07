namespace :interview do
  desc '產生所需商品'
  task create_all: :environment do
    p '開始生產商品'
    inserted_products = (1..1_000).map do |number|
      {
        sku: "2600#{number}",
        name: "簡玉珊鑰匙圈#{number}",
        market_price: rand(1000),
        gift: false,
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    Product.insert_all inserted_products
    p '生產商品完成'
    p '開始生產庫存'
    inserted_stocks = Product.all.map do |p|
      {
        product_id: p.id,
        value: rand(100),
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    Stock.insert_all inserted_stocks
    p '生產庫存完成'

    p '生產收藏商品'
    # 新增200筆收藏商品
    user = User.find_by(username: 'HanTing12345')
    FavProduct.insert_all data_factory(0, 200, user_id: user.id, note: '是喔')
    p '生產收藏商品完成'

    p '生產購物車'
    # 新增1台購物車 + 200筆購物車項目
    cart = Cart.create(user_id: user.id)
    CartItem.insert_all data_factory(200, 200, cart_id: cart.id, value: 1, name: '是嗎?')
    p '生產購物車完成'

    p '生產訂單'
    # 新增1張訂單 + 200筆訂單項目
    order = Order.create(user_id: user.id, email: user.email, number: 200, price: 200)
    Item.insert_all data_factory(400, 200, order_id: order.id, value: 1, name: '是')
    p '生產訂單完成'
  end

  desc '刪除所有東西'
  task delete_all: :environment do
    Item.delete_all
    CartItem.delete_all
    Stock.delete_all
    Cart.delete_all
    Order.delete_all
    FavProduct.delete_all
    Product.delete_all
  end

  def product_ids(limit, offset)
    Product.limit(limit).offset(offset).pluck(:id)
  end

  def data_factory(offset, limit, options = {})
    product_ids(limit, offset).map do |id|
      {
        product_id: id,
        created_at: Time.current,
        updated_at: Time.current
      }.merge(options)
    end
  end
end
