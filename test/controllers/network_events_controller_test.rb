require 'test_helper'

class NetworkEventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers 
  
  setup do
    @network_event = network_events(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:network_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network_event" do
    assert_difference('NetworkEvent.count') do
      post :create, network_event: { location_id: @network_event.location_id, name: @network_event.name, scheduled_at: @network_event.scheduled_at, event_type: @network_event.event_type }
    end

    assert_redirected_to network_event_path(assigns(:network_event))
  end

  test "should show network_event" do
    get :show, id: @network_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @network_event
    assert_response :success
  end

  test "should update network_event" do
    patch :update, id: @network_event, network_event: { location_id: @network_event.location_id, name: @network_event.name, scheduled_at: @network_event.scheduled_at, event_type: @network_event.event_type }
    assert_redirected_to network_event_path(assigns(:network_event))
  end

  test "should destroy network_event" do
    assert_difference('NetworkEvent.count', -1) do
      delete :destroy, id: @network_event
    end

    assert_redirected_to network_events_path
  end
end
