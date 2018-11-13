require 'test_helper'

class ETLDimensionsEventTest < ActiveSupport::TestCase
    def setup
        @network_event = NetworkEvent.new(
            name: 'This is a test',
            location: locations(:tuggle),
            program: programs(:network_night)
        )
        @network_event.save!

        Etl::Dimensions::Event.run

        @event_dimension = EventDimension.
            where(network_event_id: @network_event.id).
            first
    end

    test 'Event dimension ETL is idempotent' do
        assert_no_difference('EventDimension.count') do
            Etl::Dimensions::Event.run
        end
    end

    test 'All events are extracted' do
        assert_equal NetworkEvent.count, EventDimension.count
    end

    test 'Location is extracted' do
        assert_equal @network_event.location.name, @event_dimension.location
    end

    test 'Program is extracted' do
        assert_equal @network_event.program.name, @event_dimension.program
    end
end