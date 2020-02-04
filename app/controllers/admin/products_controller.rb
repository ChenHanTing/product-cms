class Admin::ProductsController < ApplicationController
  before_action :find_product, only: %i[edit update destroy show]
  before_action :authenticate_user!
  layout 'admin'

  def index
    @products = current_user.products.all.order(id: :desc)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      if params[:remember]
        cookies[:product_name] = @product.name
        cookies[:original_price] = @product.original_price
      else
        cookies.delete(:product_name)
        cookies.delete(:original_price)
      end

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

  def coupon
    # @id = params[:id]

    # if user_signed_in? && (@lab_forum.user == current_user)
    #   status = @lab_forum.solved.eql?(false) ? true : false
    #   @lab_forum.update(solved: status)
    # end

    # respond_to do |format|
    #   format.js {render 'status'}
    # end
  end

  private

  def product_params
    params.require(:product).permit(:name, :status, :number, :market_price,
                                    :original_price, :remember, :gift,
                                    :quantity_discount,
                                    :q_number,
                                    :q_switch,
                                    :quantity,
                                    pics: [])
  end

  def find_product
    @product = current_user.products.find_by(id: params[:id])
  end
end
