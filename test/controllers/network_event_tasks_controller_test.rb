require 'test_helper'

class NetworkEventTasksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @network_event_task = network_event_tasks(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:network_event_tasks)
  end

  test "should get index with uncompleted tasks" do
    get :index, params: {
      status_filter: "uncompleted_only",
      commit: "Filter tasks"
    }
    assert_response :success
    assert assigns(:network_event_tasks).present?
    assert_equal 1, assigns(:network_event_tasks).length
    assert_includes assigns(:network_event_tasks), network_event_tasks(:uncompleted_task)
  end

  test "should get index with tasks inside date range" do
    get :index, params: {
      start_date: "Friday September 2 2016",
      end_date: "Saturday September 3 2016",
      commit: "Filter tasks"
    }
    assert_response :success
    assert assigns(:network_event_tasks).present?
    assert_includes assigns(:network_event_tasks), network_event_tasks(:two)
  end

  test "should get index with common task id of one" do
    get :index, params: {
      common_task_ids: [common_tasks(:one).id],
      commit: "Filter tasks"
    }

    assert_response :success
    assert assigns(:network_event_tasks).present?
    assert_includes assigns(:network_event_tasks), network_event_tasks(:one)
  end

  test "should get index with owner id of two" do
    get :index, params: {
      owner_ids: [users(:two).id],
      commit: "Filter events"
    }

    assert_response :success
    assert assigns(:network_event_tasks).present?
    assert_includes assigns(:network_event_tasks), network_event_tasks(:two)
  end
  
  test "should update network event task" do
    patch :update, xhr: true, params: {
      id: @network_event_task,
        network_event_task: {name: @network_event_task.name,
        network_event_id: @network_event_task.network_event_id,
        common_task_id: @network_event_task.common_task_id,
        completed_at: @network_event_task.completed_at }
      }
    assert_response :success
  end
  
  test "should create network event task" do
    assert_difference('NetworkEventTask.count') do
      post :create, xhr: true, params: { 
        network_event_task: {
          name: @network_event_task.name,
          network_event_id: @network_event_task.network_event_id,
          common_task_id: @network_event_task.common_task_id
        }
      }
    end
    assert_response :success
  end
  
  test "should destroy network event task" do
    assert_difference('NetworkEventTask.count', -1) do
      delete :destroy, xhr: true,  params: { id: @network_event_task }
    end
    assert_response :success
  end
end
