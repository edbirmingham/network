require 'test_helper'

class GraduatingClassesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @graduating_class = graduating_classes(:class_of_2017)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:graduating_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create graduating_class" do
    assert_difference('GraduatingClass.count') do
      post :create, params: { graduating_class: { year: @graduating_class.year + 10 } }
    end

    assert_redirected_to graduating_class_path(assigns(:graduating_class))
  end

  test "should show graduating_class" do
    get :show, params: { id: @graduating_class }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @graduating_class }
    assert_response :success
  end

  test "should update graduating_class" do
    patch :update, params: { id: @graduating_class, graduating_class: { year: @graduating_class.year } }
    assert_redirected_to graduating_class_path(assigns(:graduating_class))
  end

  test "should destroy graduating_class" do
    assert_difference('GraduatingClass.count', -1) do
      delete :destroy, params: { id: @graduating_class }
    end

    assert_redirected_to graduating_classes_path
  end
  
  test "staff user shouldn't be able to delete graduating_classes" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @graduating_class
  end
end
