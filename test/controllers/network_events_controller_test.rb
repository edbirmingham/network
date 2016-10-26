require 'test_helper'

class NetworkEventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers 
  
  setup do
    @network_event = network_events(:tuggle_network)
    sign_in users(:one)
  end

  test "should get index with default filter" do
    get :index
    assert_response :success
    assert assigns(:network_events).blank?
  end

  test "should get index with empty date range" do
    get :index, 
      start_date: "Friday September 2 2016", 
      end_date: "Saturday September 3 2016", 
      commit: "Filter events"
    assert_response :success
    assert assigns(:network_events).blank?
  end

  test "should get index with date range including events" do
    get :index, 
      start_date: "Monday August 1 2016", 
      end_date: "Wednesday August 3 2016", 
      commit: "Filter events"
    assert_response :success
    assert assigns(:network_events).present?
    assert_equal 2, assigns(:network_events).length
  end

  test "should get index with class of 2017" do
    get :index, 
      start_date: "Monday August 1 2016", 
      end_date: "Wednesday August 3 2016", 
      graduating_class_ids: [graduating_classes(:class_of_2017).id],
      commit: "Filter events"
    
    assert_response :success
    assert assigns(:network_events).present?
    assert_includes assigns(:network_events), network_events(:tuggle_network)
    refute_includes assigns(:network_events), network_events(:carver_tour)
  end
  
  test "should get index with blue cohort" do
    get :index, 
      start_date: "Monday August 1 2016", 
      end_date: "Wednesday August 3 2016", 
      cohort_ids: [cohorts(:blue).id],
      commit: "Filter events"
    
    assert_response :success
    assert assigns(:network_events).present?
    assert_includes assigns(:network_events), network_events(:carver_tour)
    refute_includes assigns(:network_events), network_events(:tuggle_network)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network_event" do
    assert_difference('NetworkEvent.count') do
      post :create, network_event: { location_id: @network_event.location_id, name: @network_event.name, scheduled_at: @network_event.scheduled_at, program_id: @network_event.program_id }
    end

    assert_redirected_to network_event_path(assigns(:network_event))
  end
  
  test "should show network_event" do
    get :show, id: @network_event
    assert_response :success
  end

  test "should get csv" do
    time = Time.local(2016, 8, 1, 10, 5, 0)
    Timecop.travel(time) do
      get :index, :format => :csv
    end
    assert_response :success
    
    assert_equal file_data('network_events.csv'), response.body
  end

  test "should get edit" do
    get :edit, id: @network_event
    assert_response :success
  end

  test "should update network_event" do
    patch :update, id: @network_event, network_event: { location_id: @network_event.location_id, name: @network_event.name, scheduled_at: @network_event.scheduled_at, program_id: @network_event.program_id }
    assert_redirected_to network_event_path(assigns(:network_event))
  end

  test "should destroy network_event" do
    assert_difference('NetworkEvent.count', -1) do
      delete :destroy, id: @network_event
    end

    assert_redirected_to network_events_path
  end
end
