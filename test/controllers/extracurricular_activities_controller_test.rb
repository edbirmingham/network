require 'test_helper'

class ExtracurricularActivitiesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @extracurricular_activity = extracurricular_activities(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extracurricular_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extracurricular_activity" do
    assert_difference('ExtracurricularActivity.count') do
      post :create, params: { extracurricular_activity: { name: 'MyStringThree'} }
    end

    assert_redirected_to extracurricular_activity_path(assigns(:extracurricular_activity))
  end

  test "should show extracurricular_activity" do
    get :show, params: { id: @extracurricular_activity }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @extracurricular_activity }
    assert_response :success
  end

  test "should update extracurricular_activity" do
    patch :update, params: { id: @extracurricular_activity, extracurricular_activity: { name: 'MyStringFour'} }
    assert_redirected_to extracurricular_activity_path(assigns(:extracurricular_activity))
  end

  test "should destroy extracurricular_activity" do
    assert_difference('ExtracurricularActivity.count', -1) do
      delete :destroy, params: { id: @extracurricular_activity }
    end

    assert_redirected_to extracurricular_activities_path
  end
  
  test "staff user shouldn't be able to delete extracurricular_activities" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @extracurricular_activity
  end
end
