require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  test "should get add_payment" do
    get :add_payment
    assert_response :success
  end

  test "should get delete_payment" do
    get :delete_payment
    assert_response :success
  end

end
