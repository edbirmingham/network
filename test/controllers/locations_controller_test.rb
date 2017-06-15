require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @location = locations(:tuggle)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, params: { location: { name: @location.name + 'test' } }
    end

    assert_redirected_to location_path(assigns(:location))
  end

  test "should show location" do
    get :show, params: { id: @location }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @location }
    assert_response :success
  end

  test "should update location" do
    patch :update, params: { id: @location, location: { name: @location.name + 'test' } }
    assert_redirected_to location_path(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, params: { id: @location }
    end

    assert_redirected_to locations_path
  end
end
