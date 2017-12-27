require 'test_helper'

class ETLDimensionsRoleTest < ActiveSupport::TestCase
    def setup
        @participation = Participation.create!(
            level: 'attendee',
            member: members(:martin),
            network_event: network_events(:tuggle_network)
        )

        Etl::Dimensions::Role.run

        @role_dimension = RoleDimension.where(name: 'attendee').first

    end

    test 'Role dimension ETL is idempotent' do
        assert_no_difference('RoleDimension.count') do
            Etl::Dimensions::Role.run
        end
    end

    test 'Role name is extracted' do
        assert_equal @participation.level, @role_dimension.name
    end
end