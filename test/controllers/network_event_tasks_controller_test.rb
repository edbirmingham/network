require 'test_helper'

class NetworkEventTasksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @network_event_task = network_event_tasks(:one)
    sign_in users(:one)
  end
  
  test "should update with ajax" do
    xhr :patch, :update, id: @network_event_task, 
          network_event_task: {name: @network_event_task.name, 
          network_event_id: @network_event_task.network_event_id,
          common_task_id: @network_event_task.common_task_id,
          completed_at: @network_event_task.completed_at }
    assert_response :success
  end

end
