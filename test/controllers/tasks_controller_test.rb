require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @task = tasks(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get index with uncompleted tasks" do
    get :index, params: {
      status_filter: "uncompleted_only",
      commit: "Filter tasks"
    }
    assert_response :success
    assert assigns(:tasks).present?
    assert_equal 3, assigns(:tasks).length
    assert_includes assigns(:tasks), tasks(:uncompleted_task)
  end

  test "should get index with tasks inside date range" do
    get :index, params: {
      start_date: "Friday September 2 2016",
      end_date: "Saturday September 3 2016",
      commit: "Filter tasks"
    }
    assert_response :success
    assert assigns(:tasks).present?
    assert_includes assigns(:tasks), tasks(:two)
  end

  test "should get index with common task id of one" do
    get :index, params: {
      common_task_ids: [common_tasks(:one).id],
      commit: "Filter tasks"
    }

    assert_response :success
    assert assigns(:tasks).present?
    assert_includes assigns(:tasks), tasks(:one)
  end

  test "should get index with owner id of two" do
    get :index, params: {
      owner_ids: [users(:two).id],
      commit: "Filter events"
    }

    assert_response :success
    assert assigns(:tasks).present?
    assert_includes assigns(:tasks), tasks(:two)
  end
  
  test "should update task" do
    patch :update, xhr: true, params: {
      id: @task,
        task: {name: @task.name,
        network_event_id: @task.network_event_id,
        common_task_id: @task.common_task_id,
        completed_at: @task.completed_at }
      }
    assert_response :success
  end
  
  test "should create task" do
    assert_difference('Task.count') do
      post :create, xhr: true, params: { 
        task: {
          name: @task.name,
          network_event_id: @task.network_event_id,
          common_task_id: @task.common_task_id
        }
      }
    end
    assert_response :success
  end
  
  test "should destroy network event task" do
    assert_difference('Task.count', -1) do
      delete :destroy, xhr: true,  params: { id: @task }
    end
    assert_response :success
  end
end
