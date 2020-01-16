class Client::ProductsController < ApplicationController
  def index
    @products = Product.where(status: :on_shelves).order(id: :desc)
  end

  def show
    @product = Product.find_by(id: params[:id])
  end
end
