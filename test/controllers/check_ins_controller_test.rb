require 'test_helper'

class CheckInsControllerTest < ActionController::TestCase
  include Devise::TestHelpers 
  
  setup do
    @network_event = network_events(:tuggle_network)
    @participation = participations(:attendee)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    # assert_not_nil assigns(:schools)
  end

  test "should get new" do
    get :new, network_event_id: @network_event
    assert_response :success
  end

  test "should create participation during check in" do
    assert_difference('Participation.count') do
       post :create, participation: { member_id: @participation.member_id, network_event_id: @participation.network_event_id, level: @participation.level }, network_event_id: @participation.network_event_id, xhr: true
    end
    assert_response :success
  end
end
