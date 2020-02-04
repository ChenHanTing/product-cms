class Admin::OrderDiscountsController < ApplicationController
  before_action :find_discount, only: %i[edit update]
  before_action :authenticate_user!
  layout 'admin'

  def edit
    @user = User.find(current_user.id)
  end

  def update
    if @discount.update(discount_params)
      redirect_back(fallback_location: admin_order_discount_path(@discount))
    else
      respond_to { |format| format.js { render js: "alert('failure')" } }
    end
  end

  private

  def discount_params
    params.require(:discount)
          .permit(:gift, :price_discount,
                  :p_number, :d_number,
                  :p_switch, :d_switch,
                  :quota, :free_delivery_quota)
  end

  def find_discount
    @discount = Discount.find_by(user: current_user)
  end
end
