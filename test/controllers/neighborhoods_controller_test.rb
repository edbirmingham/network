require 'test_helper'

class NeighborhoodsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @neighborhood = neighborhoods(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:neighborhoods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create neighborhood" do
    assert_difference('Neighborhood.count') do
      post :create, params: { neighborhood: { name: @neighborhood.name + 'test' } }
    end

    assert_redirected_to neighborhood_path(assigns(:neighborhood))
  end

  test "should show neighborhood" do
    get :show, params: { id: @neighborhood }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @neighborhood }
    assert_response :success
  end

  test "should update neighborhood" do
    patch :update, params: { id: @neighborhood, neighborhood: { name: @neighborhood.name + 'test'} }
    assert_redirected_to neighborhood_path(assigns(:neighborhood))
  end

  test "should destroy neighborhood" do
    assert_difference('Neighborhood.count', -1) do
      delete :destroy, params: { id: @neighborhood }
    end

    assert_redirected_to neighborhoods_path
  end
  
  test "staff user shouldn't be able to delete neighborhood" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @neighborhood
  end
end
