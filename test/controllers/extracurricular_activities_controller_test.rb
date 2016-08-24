require 'test_helper'

class ExtracurricularActivitiesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
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
      post :create, extracurricular_activity: { name: 'MyStringThree'}
    end

    assert_redirected_to extracurricular_activity_path(assigns(:extracurricular_activity))
  end

  test "should show extracurricular_activity" do
    get :show, id: @extracurricular_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extracurricular_activity
    assert_response :success
  end

  test "should update extracurricular_activity" do
    patch :update, id: @extracurricular_activity, extracurricular_activity: { name: 'MyStringFour'}
    assert_redirected_to extracurricular_activity_path(assigns(:extracurricular_activity))
  end

  test "should destroy extracurricular_activity" do
    assert_difference('ExtracurricularActivity.count', -1) do
      delete :destroy, id: @extracurricular_activity
    end

    assert_redirected_to extracurricular_activities_path
  end
end
