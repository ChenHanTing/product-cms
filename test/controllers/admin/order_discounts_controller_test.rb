require 'test_helper'

class Admin::OrderDiscountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_order_discounts_index_url
    assert_response :success
  end

end
