require 'test_helper'

class NetworkEventTasksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @network_event_task = network_event_tasks(:one)
    sign_in users(:one)
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
