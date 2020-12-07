# frozen_string_literal: true
#
module Test
  class ProductsController < ::ApplicationController
    before_action :authenticate_user!
    # skip_before_action :verify_authenticity_token

    def index; end

    # url: http://localhost:3301/test/products/my_cart?id=3
    #
    #  User Load: SELECT `users`.* FROM `users`
    #             WHERE `users`.`id` = 3 ORDER BY `users`.`id` ASC LIMIT 1
    #  Cart Load: SELECT `carts`.* FROM `carts`
    #             WHERE `carts`.`id` = 3 LIMIT 1
    #  CartItem Load: SELECT `cart_items`.* FROM `cart_items`
    #                 WHERE `cart_items`.`cart_id` = 3
    #                 ORDER BY `cart_items`.`id` ASC LIMIT 1000
    def my_cart
      @cart = Cart.find_by(id: params[:id])
    end

    # url: http://localhost:3301/test/products/my_fav_products
    #
    # 這樣可能會有 n+1 query, 類似這樣:
    # SELECT * FROM users WHERE id = 3 ORDER BY id ASC LIMIT 1
    # SELECT * FROM fav_products WHERE user_id = 3
    #
    # SELECT * FROM products WHERE id = ... LIMIT 1
    # ...
    # ...
    # ...

    # 1. SELECT `users`.* FROM `users`
    #    WHERE `users`.`id` = 3 ORDER BY `users`.`id` ASC LIMIT 1
    # 2. SELECT `products`.* FROM `products`
    #    INNER JOIN `fav_products` ON `products`.`id` = `fav_products`.`product_id`
    #    WHERE `fav_products`.`user_id` = 3 ORDER BY `products`.`id` ASC LIMIT 1000
    def my_fav_products
      @products = current_user.collected_products
    end

    # url: http://localhost:3301/test/products/my_orders
    #
    # 1. SELECT `users`.* FROM `users`
    #    WHERE `users`.`id` = 3
    #    ORDER BY `users`.`id` ASC LIMIT 1
    #
    # 2. SELECT `orders`.* FROM `orders`
    #    WHERE `orders`.`user_id` = 3
    #    ORDER BY `orders`.`id` ASC LIMIT 1000
    def my_orders
      @orders = current_user.orders
    end

    # url: http://localhost:3301/test/products/my_order_detail?order_id=2
    #
    # User Load:  SELECT `users`.* FROM `users` WHERE `users`.`id` = 3
    #             ORDER BY `users`.`id` ASC LIMIT 1
    # Order Load: SELECT `orders`.* FROM `orders` WHERE `orders`.`id` = 2 LIMIT 1
    # Item Load:  SELECT `items`.* FROM `items` WHERE `items`.`order_id` = 2
    def my_order_detail
      @order = Order.find_by(id: params[:order_id])
    end

    def add_to_cart
      product = Product.find_by(id: params[:id]).stock
      product.stock.update(value: (product.stock.value - params[:number]))

      @cart ||= Cart.first_or_create(user_id: current_user.id)
      @cart.cart_items.create(product_id: product.id)
    end

    def add_fav_products
      current_user.fav_products.create(product_id: params[:id], note: params[:note])
      @success_message = "<b>Success!</b> note: #{params[:note]}"
    end

    def create_order
      cart = Cart.find_by(id: params[:id])

      @order = Order.create!(
        user_id: current_user.id,
        email: current_user.email,
        number: 200,
        price: 200
      )

      order_items = cart.cart_items.map do |item|
                      @order.items.new(
                        name: item.name,
                        value: item.value,
                        product_id: item.product_id
                      )
                    end

      Item.import! order_items

      # 刪除購物車商品、購物車
      cart.cart_items.delete_all
      cart.delete
    end
  end
end