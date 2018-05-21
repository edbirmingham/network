class Reports::StudentsByProgramController < ApplicationController
  def index
    select_clause = <<-SELECT
    '2017-2018'::text AS school_year,
    programs.name AS name_of_program,
    COUNT(participations.id) AS total_attendees,
    COUNT(DISTINCT participations.member_id) AS unique_attendees,
    round(COUNT(participations.id)/COUNT(DISTINCT network_events.id)) AS average_attendance
    SELECT

    @rows = NetworkEvent.
      select(select_clause).
      joins(:program, :participations).
      group('programs.name').
      where("participations.level = 'attendee' AND network_events.scheduled_at > '2017/07/01'")

    @total_attendees = @rows.map(&:total_attendees).sum
    @total_unique_attendees = Participation.
      joins(:network_event).
      where("participations.level = 'attendee' AND network_events.scheduled_at > '2017/07/01'").
      distinct.
      count(:member_id)
    if @rows.present?
      @average_attendance = @total_attendees / @rows.length
    else
      @average_attendance = 0
    end
  end
end
