class Etl::Facts::Participation
    def self.run
        participations = Participation.includes(:network_event)
        participations.all.each do |participation|
            attributes = {
                participation_id: participation.id,
                date_dimension_id: date_dimension(participation),
                member_dimension_id: member_dimension(participation),
                event_dimension_id: event_dimension(participation),
                role_dimension_id: role_dimension(participation),
                grade_dimension_id: grade_dimension(participation),
                invited_count: invited_count_metric(participation),
                attended_count: 1,
                hours: participation.network_event.duration / 60.0
            }

            if ParticipationFact.where(participation_id: attributes[:participation_id]).exists?
                ParticipationFact.
                    where(participation_id: attributes[:participation_id]).
                    update_all(attributes)
            else
                ParticipationFact.create(attributes)
            end
        end
    end

    private

    def self.date_dimension(participation)
        DateDimension.
            where(date: participation.network_event.scheduled_at).
            first.
            id
    end

    def self.event_dimension(participation)
        EventDimension.
            where(network_event_id: participation.network_event_id).
            first.
            id
    end

    def self.grade_dimension(participation)
        if participation.member.graduating_class.present?
            participation_date =
                participation.network_event.scheduled_at || participation.created_at

            grade = participation.
                member.
                graduating_class.
                grade(participation_date)

            GradeDimension.
                where(name: GradeDimension.sanitize(grade)).
                first.
                id
        else
            GradeDimension.unspecified.id
        end
    end

    def self.invited_count_metric(participation)
        participation.
            network_event.
            invitees.
            where(id: participation.member_id).
            count
    end

    def self.member_dimension(participation)
        MemberDimension.
            where(member_id: participation.member_id).
            first.
            id
    end

    def self.role_dimension(participation)
        RoleDimension.
            where(name: participation.level).
            first.
            id
    end

end