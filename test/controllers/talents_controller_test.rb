require 'test_helper'

class TalentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @talent = talents(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:talents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create talent" do
    assert_difference('Talent.count') do
      post :create, talent: { name: @talent.name + 'test' }
    end

    assert_redirected_to talent_path(assigns(:talent))
  end

  test "should show talent" do
    get :show, id: @talent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @talent
    assert_response :success
  end

  test "should update talent" do
    patch :update, id: @talent, talent: { name: @talent.name + 'test' }
    assert_redirected_to talent_path(assigns(:talent))
  end

  test "should destroy talent" do
    assert_difference('Talent.count', -1) do
      delete :destroy, id: @talent
    end

    assert_redirected_to talents_path
  end
end
