require 'test_helper'

class NetworkEventsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @network_event = network_events(:tuggle_network)
    sign_in users(:one)
  end

  test "should get json with pagination" do
    get :index, params: { :format => :json }
    assert_pagination assigns(:network_events),
      "Events json should be paginated."
  end

  test "should get index with pagination" do
    get :index
    assert_pagination assigns(:network_events),
      "Events listing should be paginated."
  end

  test "should get index with default filter" do
    get :index
    assert_response :success
    # assert assigns(:network_events).blank?
    assert_equal 1, assigns(:network_events).length
    assert_includes assigns(:network_events), network_events(:dateless_event)
  end

  test "should get index with unscheduled events" do
    get :index, params: {
      unscheduled_events_only: true,
      commit: "Filter events"
    }
    assert_response :success
    assert assigns(:network_events).present?
    assert_equal 1, assigns(:network_events).length
    assert_includes assigns(:network_events), network_events(:dateless_event)
  end

  test "should get index with empty date range" do
    get :index, params: {
      start_date: "Friday September 2 2016",
      end_date: "Saturday September 3 2016",
      commit: "Filter events"
    }
    assert_response :success
    assert assigns(:network_events).present?
    assert_includes assigns(:network_events), network_events(:dateless_event)
  end

  test "should get index with date range including events" do
    get :index, params: {
      start_date: "Monday August 1 2016",
      end_date: "Wednesday August 3 2016",
      commit: "Filter events"
    }
    assert_response :success
    assert assigns(:network_events).present?
    assert_equal 3, assigns(:network_events).length
  end

  test "should get index with uncompleted transportation task" do
    get :index, params: {
      common_task_ids: [common_tasks(:two).id],
      commit: "Filter events"
    }
    assert_response :success
    assert assigns(:network_events).present?
    assert_equal 1, assigns(:network_events).length
  end

  test "should get index with class of 2017" do
    get :index, params: {
      start_date: "Monday August 1 2016",
      end_date: "Wednesday August 3 2016",
      graduating_class_ids: [graduating_classes(:class_of_2017).id],
      commit: "Filter events"
    }

    assert_response :success
    assert assigns(:network_events).present?
    assert_includes assigns(:network_events), network_events(:tuggle_network)
    refute_includes assigns(:network_events), network_events(:carver_tour)
  end

  test "should get index with blue cohort" do
    get :index, params: {
      start_date: "Monday August 1 2016",
      end_date: "Wednesday August 3 2016",
      cohort_ids: [cohorts(:blue).id],
      commit: "Filter events"
    }

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
      post :create, params: { network_event: {
        location_id: @network_event.location_id,
        name: @network_event.name,
        scheduled_at_date: @network_event.scheduled_at.to_date,
        scheduled_at_time: @network_event.scheduled_at.to_time,
        program_id: @network_event.program_id
        }
      }
    end

    assert_redirected_to network_event_path(assigns(:network_event))
  end

  test "should show network_event" do
    get :show, params: { id: @network_event }
    assert_response :success
    assert_select '.sign_up__attendee', 'Sign Up Attendee'
    assert_select '.sign_up__attendee > a[href$=?]', "/#{@network_event.id}/sign_ups/new?level=attendee"
    assert_select '.sign_up__volunteer', 'Sign Up Volunteer'
    assert_select '.sign_up__volunteer > a[href$=?]', "/#{@network_event.id}/sign_ups/new?level=volunteer"
  end

  test "should get csv" do
    time = Time.local(2016, 8, 1, 10, 5, 0)
    Timecop.travel(time) do
      get :index, params: { :format => :csv }
    end
    assert_response :success

    assert_equal file_data('network_events.csv'), response.body
  end

  test "should get csv without pagination" do
    time = Time.local(2016, 8, 1, 10, 5, 0)
    Timecop.travel(time) do
      get :index, params: { :format => :csv }
    end

    refute_pagination assigns(:network_events),
      "Events csv export should not be paginated."
  end

  test "should get edit" do
    get :edit, params: { id: @network_event }
    assert_response :success
  end

  test "should update network_event" do
    patch :update, params: { id: @network_event,
      network_event: { location_id: @network_event.location_id,
      name: @network_event.name,
      scheduled_at_date: @network_event.scheduled_at.to_date,
      scheduled_at_time: @network_event.scheduled_at.to_time,
      program_id: @network_event.program_id
      }
    }
    assert_redirected_to network_event_path(assigns(:network_event))
  end

  test "should destroy network_event" do
    assert_difference('NetworkEvent.count', -1) do
      delete :destroy, params: { id: @network_event }
    end
    assert_redirected_to network_events_path
  end

  test "staff user shouldn't be able to delete network_event" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef')
    ability = Ability.new(user)
    assert ability.cannot? :delete, @network_event
  end
end
