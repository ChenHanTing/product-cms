class UsersController < ApplicationController
  before_action :find_user, only: %i[edit show update]
  before_action :authenticate_user!, only: %i[edit update]
  layout 'admin'

  def show
  end

  def edit
  end

  def update
    current_user.update!(user_params)

    # 若在優惠管理系統送出的表單轉指到 /admin/order_discounts/:id/edit
    if request.referer.split('/')[-3] == 'order_discounts'
      redirect_to edit_admin_order_discount_path(Discount.find_by(user: current_user))
    else
      redirect_to current_user
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :name, :website,
                                 :bio, :email, :phone, :gender,
                                 :discount_sw, :number, :discount_price)
  end
end
