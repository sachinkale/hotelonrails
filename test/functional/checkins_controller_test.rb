require 'test_helper'

class CheckinsControllerTest < ActionController::TestCase
  setup do
    @checkin = checkins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checkins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checkin" do
    assert_difference('Checkin.count') do
      post :create, :checkin => @checkin.attributes
    end

    assert_redirected_to checkin_path(assigns(:checkin))
  end

  test "should show checkin" do
    get :show, :id => @checkin.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @checkin.to_param
    assert_response :success
  end

  test "should update checkin" do
    put :update, :id => @checkin.to_param, :checkin => @checkin.attributes
    assert_redirected_to checkin_path(assigns(:checkin))
  end

  test "should destroy checkin" do
    assert_difference('Checkin.count', -1) do
      delete :destroy, :id => @checkin.to_param
    end

    assert_redirected_to checkins_path
  end
end
