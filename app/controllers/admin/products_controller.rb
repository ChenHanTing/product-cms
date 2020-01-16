class Admin::ProductsController < ApplicationController
  before_action :find_product, only: %i[edit update destroy show]
  before_action :authenticate_user!
  layout 'admin'

  def index
    @products = current_user.products.all.order(id: :desc)
  end

  def create
    serial_num = (0...5).map { ('A'..'z').to_a[rand(26)] }.join

    @product = Product.new(product_params)
    @product.user = current_user
    @product.sku = "#{Time.current.to_i}#{serial_num}"

    if @product.save
      respond_to :js
    else
      respond_to { |format| format.js { render js: "alert('failure')" } }
    end
  end

  def edit; end

  def show; end

  def update
    if @product.update(product_params)
      respond_to :js
    else
      respond_to { |format| format.js { render js: "alert('failure')" } }
    end
  end

  def destroy
    @product_id = @product.id
    @product&.destroy

    respond_to do |format|
      format.js
    end
  end

  def status
  end

  private

  def product_params
    params.require(:product).permit(:name, :status, :number, :market_price,
                                    :original_price, pics: [])
  end

  def find_product
    @product = current_user.products.find_by(id: params[:id])
  end
end
