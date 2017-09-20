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

  test "should show cohort's cohortians" do
    get :show, params: { id: cohorts(:green) }
    assert_select 'td', 'Rosa Parks'
  end

  test "should not show cohortians from other cohorts" do
    get :show, params: { id: cohorts(:green) }
    assert_select 'td', text: 'Martin King', count: 0
  end

  test "should have cohort id hidden field" do
    get :show, params: { id: cohorts(:green) }
    assert_select "form input[name=cohort_id][type=hidden]" do
      assert_select "[value=?]", cohorts(:green).id.to_s
    end
  end

  test "should have member multi-select" do
    get :show, params: { id: cohorts(:green) }
    assert_select "form select[name='member_ids[]']"
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
  
  test "staff user shouldn't be able to delete cohort" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @cohort
  end 
end
