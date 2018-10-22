class Etl::Facts::Programming
  def self.run
    events = NetworkEvent.all
    events.each do |event|
      attributes = {
        network_event_id: event.id,
        event_dimension_id: event_dimension(event),
        date_dimension_id: date_dimension(event),
        event_count: 1,
        hours: hours(event),
        invitee_count: event.invitees.count,
        attendee_count: event.participations.attendee.count
      }

      if ProgrammingFact.where(network_event_id: attributes[:network_event_id]).exists?
        ProgrammingFact.
          where(network_event_id: attributes[:network_event_id]).
          update_all(attributes)
      else
        ProgrammingFact.create(attributes)
      end
    end
  end

  def self.date_dimension(event)
    DateDimension.
      where(date: event.scheduled_at).
      first.
      id
  end

  def self.event_dimension(event)
    EventDimension.
      where(network_event_id: event.id).
      first.
      id
  end

  def self.hours(event)
    hours = 0
    if event.duration.present?
      hours = event.duration / 60.0
      cohort_count = event.cohort_assignments.count
  
      if cohort_count > 1
        hours = hours * cohort_count
      end
    end

    hours
  end
end