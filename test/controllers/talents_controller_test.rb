require 'test_helper'

class TalentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

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
      post :create, params: { talent: { name: @talent.name + 'test' } }
    end

    assert_redirected_to talent_path(assigns(:talent))
  end

  test "should show talent" do
    get :show, params: { id: @talent }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @talent }
    assert_response :success
  end

  test "should update talent" do
    patch :update, params: { id: @talent, talent: { name: @talent.name + 'test' } }
    assert_redirected_to talent_path(assigns(:talent))
  end

  test "should destroy talent" do
    assert_difference('Talent.count', -1) do
      delete :destroy, params: { id: @talent }
    end

    assert_redirected_to talents_path
  end
  
  test "staff user shouldn't be able to delete talent" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @talent
  end
end
