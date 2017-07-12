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
  
  test "When a network event is copied the id should be present" do
    original = network_events(:tuggle_network)
    copy = original.copy
    assert copy.id.present?
  end
  
  test "When a network event is copied the id should be different" do
    original = network_events(:tuggle_network)
    copy = original.copy
    refute_equal original.id, copy.id
  end
  
  test "When a network event is copied the name should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.name.present?, 
      "Network event fixture expected to have a name"
      
    copy = original.copy
    assert_equal original.name, copy.name
  end
  
  test "When a network event is copied, scheduled at should be the empty" do
    original = network_events(:tuggle_network)
    assert_guard original.scheduled_at.present?, 
      "Network event fixture expected to have a scheduled at date/time"
      
    copy = original.copy
    assert_nil copy.scheduled_at
  end
  
  test "When a network event is copied the created at date should be different" do
    original = network_events(:tuggle_network)
    assert_guard original.created_at.present?, 
      "Network event fixture expected to have a created at date/time"
      
    copy = original.copy
    refute_equal original.created_at, copy.created_at
  end
  
  test "When a network event is copied the created at date should be present" do
    original = network_events(:tuggle_network)
    copy = original.copy
    refute_nil copy.created_at
  end
  
  test "When a network event is copied the updated at date should be different" do
    original = network_events(:tuggle_network)
    assert_guard original.updated_at.present?, 
      "Network event fixture expected to have a updated at date/time"
      
    copy = original.copy
    refute_equal original.updated_at, copy.updated_at
  end
  
  test "When a network event is copied the updated at date should be present" do
    original = network_events(:tuggle_network)
    copy = original.copy
    refute_nil copy.updated_at
  end
  
  test "When a network event is copied the duration should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.duration.present?, 
      "Network event fixture expected to have a duration"
      
    copy = original.copy
    assert_equal original.duration, copy.duration
  end
  
  test "When a network event is copied, needs transportation should be the same" do
    original = network_events(:tuggle_network)
    assert_guard !original.needs_transport.nil?, 
      "Network event fixture expected to have a needs transportation"
      
    copy = original.copy
    assert_equal original.needs_transport, copy.needs_transport
  end
  
  test "When a network event is copied the transport ordered on date should be empty" do
    original = network_events(:tuggle_network)
    assert_guard original.transport_ordered_on.present?, 
      "Network event fixture expected to have a transport ordered on date"
      
    copy = original.copy
    assert_nil copy.transport_ordered_on
  end
  
  test "When a network event is copied the notes should be empty" do
    original = network_events(:tuggle_network)
    assert_guard original.notes.present?, 
      "Network event fixture expected to have notes"
      
    copy = original.copy
    assert_nil copy.notes
  end
  
  test "When a network event is copied the status should be empty" do
    original = network_events(:tuggle_network)
    assert_guard original.status.present?, 
      "Network event fixture expected to have status"
      
    copy = original.copy
    assert_nil copy.status
  end
  
  test "When a network event is copied the program should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.program.present?, 
      "Network event fixture expected to have a program"
      
    copy = original.copy
    assert_equal original.program, copy.program
  end
  
  test "When a network event is copied the location should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.location.present?, 
      "Network event fixture expected to have a location"
      
    copy = original.copy
    assert_equal original.location, copy.location
  end
  
  test "When a network event is copied the user should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.user.present?, 
      "Network event fixture expected to have a user"
      
    copy = original.copy
    assert_equal original.user, copy.user
  end
  
  test "When a network event is copied the site contacts should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.site_contacts.present?, 
      "Network event fixture expected to have site contacts"
      
    copy = original.copy
    assert_equal original.site_contacts, copy.site_contacts
  end
  
  test "When a network event is copied the school contacts should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.school_contacts.present?, 
      "Network event fixture expected to have school contacts"
      
    copy = original.copy
    assert_equal original.school_contacts, copy.school_contacts
  end
  
  test "When a network event is copied the volunteers should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.volunteers.present?, 
      "Network event fixture expected to have volunteers"
      
    copy = original.copy
    assert_equal original.volunteers, copy.volunteers
  end
  
  test "When a network event is copied the graduating classes should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.graduating_classes.present?, 
      "Network event fixture expected to have graduating classes"
      
    copy = original.copy
    assert_equal original.graduating_classes, copy.graduating_classes
  end
  
  test "When a network event is copied the organizations should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.organizations.present?, 
      "Network event fixture expected to have organizations"
      
    copy = original.copy
    assert_equal original.organizations, copy.organizations
  end
  
  test "When a network event is copied the schools should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.schools.present?, 
      "Network event fixture expected to have schools"
      
    copy = original.copy
    assert_equal original.schools, copy.schools
  end
  
  test "When a network event is copied the cohorts should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.cohorts.present?, 
      "Network event fixture expected to have cohorts"
      
    copy = original.copy
    assert_equal original.cohorts, copy.cohorts
  end
  
  test "When a network event is copied the participants should not be copied" do
    original = network_events(:tuggle_network)
    assert_guard original.participants.present?, 
      "Network event fixture expected to have participants"
      
    copy = original.copy
    assert_empty copy.participants
  end
  
  test "When a network event is copied the tasks should be the same" do
    original = network_events(:tuggle_network)
    assert_guard original.network_event_tasks.present?, 
      "Network event fixture expected to have tasks"
      
    copy = original.copy
    assert_equal original.network_event_tasks.count, copy.network_event_tasks.count
  end
  
  test "When a network event is copied the cohorts can be overridden" do
    original = network_events(:tuggle_network)
    assert_guard original.cohorts.present?, 
      "Network event fixture expected to have cohorts"
    assert_guard original.cohorts.exclude?(cohorts(:red)), 
      "Network event fixture cohorts expected to not include red"
      
    overrides = { cohort_ids: [cohorts(:red).id, cohorts(:purple).id]}
    copy = original.copy(overrides)
    assert_equal Cohort.where(id: overrides[:cohort_ids]), copy.cohorts
  end
  
  test "When a network event is copied the cohorts can be removed" do
    original = network_events(:tuggle_network)
    assert_guard original.cohorts.present?, 
      "Network event fixture expected to have cohorts"
      
    overrides = { cohort_ids: []}
    copy = original.copy(overrides)
    assert_equal Cohort.where(id: overrides[:cohort_ids]), copy.cohorts
  end
  
end
