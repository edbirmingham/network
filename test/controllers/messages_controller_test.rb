require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
  end

  test "'new' action creates a message" do
    get :new, params:{ network_event_id: network_events(:tuggle_network).id }
    assert_response :success

    assert_equal MessageForm, assigns(:message).class
  end

  test "'create' action creates a message" do
    member_id = members(:one).id
    tuggle = network_events(:tuggle_network)
    post :create, params:{ network_event_id: tuggle.id, message: {subject: "hello!", body: "hello everyone", recipient_ids: [member_id]}}

    assert_redirected_to network_event_message_path(tuggle, tuggle.messages.last)

    assert_equal 1, tuggle.messages.count
  end
end
