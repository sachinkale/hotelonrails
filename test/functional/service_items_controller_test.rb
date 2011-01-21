require 'test_helper'

class ServiceItemsControllerTest < ActionController::TestCase
  test "should get add_service" do
    get :add_service
    assert_response :success
  end

  test "should get delete_service" do
    get :delete_service
    assert_response :success
  end

end
