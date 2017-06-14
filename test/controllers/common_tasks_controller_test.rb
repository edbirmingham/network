require 'test_helper'

class CommonTasksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @common_task = common_tasks(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:common_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create common_task" do
    assert_difference('CommonTask.count') do
      post :create, params: { common_task: { name: @common_task.name, user_id: @common_task.user_id } }
    end

    assert_redirected_to common_task_path(assigns(:common_task))
  end

  test "should show common_task" do
    get :show, params: { id: @common_task }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @common_task }
    assert_response :success
  end

  test "should update common_task" do
    patch :update, params: { id: @common_task, common_task: { name: @common_task.name, user_id: @common_task.user_id } }
    assert_redirected_to common_task_path(assigns(:common_task))
  end

  test "should destroy common_task" do
    assert_difference('CommonTask.count', -1) do
      delete :destroy, params: { id: @common_task }
    end

    assert_redirected_to common_tasks_path
  end
end
