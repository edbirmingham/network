require 'test_helper'

class CohortsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @cohort = cohorts(:purple)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cohorts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cohort" do
    assert_difference('Cohort.count') do
      post :create, params: { cohort: { name: @cohort.name + 'test' } }
    end

    assert_redirected_to cohort_path(assigns(:cohort))
  end

  test "should show cohort" do
    get :show, params: { id: @cohort }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @cohort }
    assert_response :success
  end

  test "should update cohort" do
    patch :update, params: { id: @cohort, cohort: { name: @cohort.name + 'test' } }
    assert_redirected_to cohort_path(assigns(:cohort))
  end

  test "should destroy cohort" do
    assert_difference('Cohort.count', -1) do
      delete :destroy, params: { id: @cohort }
    end

    assert_redirected_to cohorts_path
  end
end
