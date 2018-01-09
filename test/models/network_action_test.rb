require 'test_helper'

class NetworkActionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def network_action_attributes(additional_attributes={})
    {
      network_event: network_events(:dateless_event),
      actor: members(:one),
      owner: users(:one),
      description: 'Really cool offer',
      priority: "needs_priority",
      status: "created"
    }.merge(additional_attributes)
  end
  
  test "Network should be able to create a Network Action" do
    network_action = NetworkAction.create!(network_action_attributes)
    
    assert_instance_of( NetworkAction, network_action)
  end
  
end
