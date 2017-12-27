require 'test_helper'

class ETLFactsParticipationTest < ActiveSupport::TestCase
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

        @participation_fact = ParticipationFact.
            where(participation_id: @participation.id).
            first
    end

    test 'Participation fact ETL is idempotent' do
        assert_no_difference('ParticipationFact.count') do
            Etl::Facts::Participation.run
        end
    end

    test 'All participations are extracted' do
        assert_equal Participation.count, ParticipationFact.count
    end

    test 'Date dimension is correct for event with a date set' do
        date_dimension = DateDimension.
            where(date: @network_event.scheduled_at).
            first
        assert_equal date_dimension.id, @participation_fact.date_dimension_id
    end

    test 'Date dimension is set to unscheduled when no date is set' do
        @network_event_sans_date = NetworkEvent.new(
            name: 'This is a test without date',
            location: locations(:tuggle),
            program: programs(:network_night)
        )
        @network_event_sans_date.save!

        @participation_sans_date = Participation.new(
            network_event: @network_event_sans_date,
            member: members(:rosa),
            level: 'attendee'
        )
        @participation_sans_date.save!

        Etl::Dimensions::Event.run
        Etl::Facts::Participation.run

        @participation_fact_sans_date = ParticipationFact.
            where(participation_id: @participation_sans_date.id).
            first

        date_dimension = DateDimension.
            where(date: @network_event_sans_date.scheduled_at).
            first

        assert_equal date_dimension.id, @participation_fact_sans_date.date_dimension_id
    end

    test 'Member dimension is correct' do
        member_dimension = MemberDimension.
            where(member_id: @participation.member_id).
            first
        assert_equal member_dimension.id, @participation_fact.member_dimension_id
    end

    test 'Event dimension is correct' do
        event_dimension = EventDimension.
            where(network_event_id: @participation.network_event_id).
            first
        assert_equal event_dimension.id, @participation_fact.event_dimension_id
    end

    test 'Role dimension is correct' do
        role_dimension = RoleDimension.
            where(name: @participation.level).
            first
        assert_equal role_dimension.id, @participation_fact.role_dimension_id
    end

    test 'Grade dimension is correct when member has a graduating class' do
        grade = @participation.
            member.
            graduating_class.
            grade(@participation.network_event.scheduled_at)

        grade_dimension = GradeDimension.
            where(name: grade).
            first
        assert_equal grade_dimension.id, @participation_fact.grade_dimension_id
    end

    test 'Grade dimension is correct when member does not have a graduating class' do
        participation_sans_grade = Participation.new(
            network_event: @network_event,
            member: members(:rosa),
            level: 'attendee'
        )
        participation_sans_grade.save!

        Etl::Facts::Participation.run

        participation_fact_sans_grade = ParticipationFact.
            where(participation_id: participation_sans_grade.id).
            first

        grade_dimension = GradeDimension.unspecified

        assert_equal grade_dimension.id, participation_fact_sans_grade.grade_dimension_id
    end

    test 'Grade dimension is correct when event has not been scheduled' do
        network_event_sans_date = NetworkEvent.new(
            name: 'This is a test without date',
            location: locations(:tuggle),
            program: programs(:network_night)
        )
        network_event_sans_date.save!

        participation_sans_date = Participation.new(
            network_event: network_event_sans_date,
            member: members(:martin),
            level: 'attendee'
        )
        participation_sans_date.save!

        Etl::Dimensions::Event.run
        Etl::Facts::Participation.run

        participation_fact_sans_date = ParticipationFact.
            where(participation_id: participation_sans_date.id).
            first

        grade = participation_sans_date.
            member.
            graduating_class.
            grade(Date.today)

        grade_dimension = GradeDimension.
            where(name: GradeDimension.sanitize(grade)).
            first

        assert_equal grade_dimension.id, participation_fact_sans_date.grade_dimension_id
    end

    test 'Invitee count metric is correct' do
        invited_count = @network_event.
            invitees.
            where(id: @participation.member_id).
            count
        assert_equal invited_count, @participation_fact.invited_count
    end

    test 'Attended count metric is correct' do
        assert_equal 1, @participation_fact.attended_count
    end

    test 'Hours metric is correct' do
        hours = @network_event.duration / 60.0
        assert_equal hours, @participation_fact.hours
    end
end