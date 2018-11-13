require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  
  setup do
    sign_in users(:dashboard_user)
  end
  
  test "should get index with users events task" do
    get :index, params: {
      dashboard_filter: "event_tasks",
      commit: "Filter tasks"
    } 
    assert_response :success
    assert assigns(:events).present?
  end
  
  test "should get index with users project tasks" do
    get :index, params: {
      dashboard_filter: "project_tasks",
      commit: "Filter tasks"
    } 
    assert_response :success
    assert assigns(:projects).present?
  end

end
