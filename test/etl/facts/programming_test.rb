require 'test_helper'

class EtlFactsProgrammingTest < ActiveSupport::TestCase
  def setup
    @network_event = NetworkEvent.new(
        name: 'This is a test',
        location: locations(:tuggle),
        program: programs(:network_night),
        schools: [schools(:tuggle)],
        scheduled_at: '2016-08-01'.to_date
    )
    @network_event.save!

    members(:martin).update_attributes(school: schools(:tuggle))

    @participation = Participation.new(
        network_event: @network_event,
        member: members(:martin),
        level: 'attendee'
    )
    @participation.save!

    Etl::Runner.run

    @programming_fact = ProgrammingFact.
        where(network_event_id: @network_event.id).
        first
  end

  test 'Programming fact ETL is idempotent' do
    assert_no_difference('ProgrammingFact.count') do
      Etl::Facts::Programming.run
    end
  end

  test 'All programming is extracted' do
    assert_equal NetworkEvent.count, ProgrammingFact.count
  end

  test 'Event dimension is correct' do
    event_dimension = EventDimension.
      where(network_event_id: @network_event.id).
      first

    assert_equal event_dimension.id, @programming_fact.event_dimension_id
  end

  test 'Date dimension is correct for event with a date set' do
    date_dimension = DateDimension.
      where(date: @network_event.scheduled_at).
      first

    assert_equal date_dimension.id, @programming_fact.date_dimension_id
  end

  test 'Date dimension is set to unscheduled when no date is set' do
    network_event_sans_date = NetworkEvent.new(
        name: 'This is a test without date',
        location: locations(:tuggle),
        program: programs(:network_night)
    )
    network_event_sans_date.save!

    Etl::Dimensions::Event.run
    Etl::Facts::Programming.run

    programming_fact_sans_date = ProgrammingFact.
        where(network_event_id: network_event_sans_date.id).
        first

    date_dimension = DateDimension.
        where(date: network_event_sans_date.scheduled_at).
        first

    assert_equal date_dimension.id, programming_fact_sans_date.date_dimension_id
  end

  test 'Event count metric is correct' do
    assert_equal 1, @programming_fact.event_count
  end

  test 'Event hours metric is correct' do
    assert_equal @network_event.duration / 60.0, @programming_fact.hours
  end

  test 'Invitee count metric is correct' do
    assert_equal @network_event.invitees.count, @programming_fact.invitee_count
  end

  test 'Attendee count metric is correct' do
    assert_equal @network_event.participations.attendee.count, @programming_fact.attendee_count
  end
end