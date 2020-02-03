class Admin::OrderDiscountsController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'

  def index
  end

  # private

  # def order_params
  #   params[:order].permit(:number, :delivery)
  # end

  # def find_product
  #   @product = Product.find_by(id: params[:id])
  # end
end
