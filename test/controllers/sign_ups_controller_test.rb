require 'test_helper'

class SignUpsControllerTest < ActionController::TestCase
  include Devise::TestHelpers 
  
  setup do
    @participation = participations(:attendee)
    @member = members(:one)
    @network_event = network_events(:tuggle_network)
    sign_in users(:one)
  end

  test "should get new" do
    get :new, :network_event_id => @network_event, :level => @participation.level
    assert_response :success
  end

  test "should create participation with already created member" do
    assert_difference('Participation.count') do
      post :create, participation: { level: @participation.level, member_id: @member}, network_event_id: @network_event, commit: "Confirm attendance"
    end
    assert_redirected_to new_network_event_sign_up_path(@network_event, :level => @participation.level)
  end

  test "should create participation with newly created member" do
    assert_difference('Participation.count') do
      post :create, member: { email: @member.email, first_name: @member.first_name, identity: @member.identity, last_name: @member.last_name, phone: @member.phone },level: @participation.level, member_id: nil, network_event_id: @network_event
    end
    assert_redirected_to new_network_event_sign_up_path(@network_event, :level => @participation.level)
  end
  
  test "should create participation with updated member" do
    assert_difference('Participation.count') do
      post :create, member: { email: @member.email, first_name: @member.first_name, identity: @member.identity, last_name: @member.last_name, phone: @member.phone },level: @participation.level, member_id: @member, network_event_id: @network_event
    end
    assert_redirected_to new_network_event_sign_up_path(@network_event, :level => @participation.level)
  end
end
