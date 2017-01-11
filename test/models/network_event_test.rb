require 'test_helper'

class NetworkEventTest < ActiveSupport::TestCase
  
  def network_event_attributes(additional_attributes={})
    {
      name: 'Test',
      program: programs(:network_night),
      scheduled_at: 1.day.from_now,
      location: locations(:tuggle)
    }.merge(additional_attributes)
  end 
  
  test "NetworkEvent invitees requires cohort, school or graduating class" do
    network_event = NetworkEvent.create!(network_event_attributes)
    
    assert_empty network_event.invitees
  end 
  
  test "Network invitees should be constrained by graduation class" do
    network_event = NetworkEvent.create!(
      network_event_attributes(
        graduating_class_ids: [graduating_classes(:class_of_2016).id]
      )
    )
    
    assert_includes network_event.invitees, members(:one)
    refute_includes network_event.invitees, members(:two)
  end
  
end
