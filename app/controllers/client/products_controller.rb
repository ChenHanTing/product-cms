class Client::ProductsController < ApplicationController
  before_action :find_product, only: %i[show order]

  def index
    @products = Product&.where(status: :on_shelves)&.order(id: :desc)
  end

  def show
  end

  def order
    @order = Order.new(order_params)
    @order.name = @product.name
    @order.price = @product.market_price * params[:order][:number].to_i
    @order.user_id = current_user.id

    if @order.number.nil?
      errors('Quantity field cannot be blank!')

      back
    elsif @product.number < @order.number
      errors("There aren't enough quantity of commodity.")

      back
    elsif current_user.wallet < @order.price
      errors(:number, "You don't have enough money to buy this.")

      back
    elsif @order.save
      @product.update!(number: @product.number - @order.number)
      current_user.update!(wallet: current_user.wallet - @order.price)

      redirect_to client_products_path
    end
  end

  private

  def order_params
    params[:order].permit(:number, :delivery)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def back
    redirect_back(fallback_location: client_product_path(@product))
  end

  def errors(str)
    @order.errors.add(:number, str)
  end
end
