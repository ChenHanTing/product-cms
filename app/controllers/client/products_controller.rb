class Client::ProductsController < ApplicationController
  before_action :find_product, only: %i[show order]

  def index
    @products = Product&.where(status: :on_shelves)&.order(id: :desc)
  end

  def show
  end

  def order
    serial_num = (0...5).map { ('A'..'z').to_a[rand(26)] }.join

    @order = Order.new(order_params)
    @order.code = "order_#{Time.current.to_i}#{serial_num}"
    @order.name = @product.name
    @order.price = @product.market_price * params[:order][:number].to_i
    @order.user_id = current_user.id

    if @product.number < @order.number
      @order.errors.add(:number, "There aren't enough quantity of commodity.")

      redirect_back(fallback_location: client_product_path(@product))
    elsif current_user.wallet < @order.price
      @order.errors.add(:number, "You don't have enough money to buy this.")

      redirect_back(fallback_location: client_product_path(@product))
    elsif @order.save
      @product.update!(number: @product.number - @order.number)
      current_user.update!(wallet: current_user.wallet - @order.price)

      redirect_to client_products_path
    end
  end

  private

  def order_params
    params[:order].permit(:number)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
