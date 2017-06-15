require 'test_helper'

class IdentitiesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @identity = identities(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:identities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create identity" do
    assert_difference('Identity.count') do
      post :create, params: { identity: { name: @identity.name + 'test' } }
    end

    assert_redirected_to identity_path(assigns(:identity))
  end

  test "should show identity" do
    get :show, params: { id: @identity }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @identity }
    assert_response :success
  end

  test "should update identity" do
    patch :update, params: { id: @identity, identity: { name: @identity.name + 'test' } }
    assert_redirected_to identity_path(assigns(:identity))
  end

  test "should destroy identity" do
    assert_difference('Identity.count', -1) do
      delete :destroy, params: { id: @identity }
    end

    assert_redirected_to identities_path
  end
end
