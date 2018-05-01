class Reports::StudentsByProgramController < ApplicationController
  def index
    select_clause = <<-SELECT
    '2017-2018' AS school_year,
    programs.name AS name_of_program,
    COUNT(participations.id) AS total_students,
    COUNT(DISTINCT participations.member_id) AS unique_students,
    round(COUNT(participations.id)/count(DISTINCT network_events.id)) AS average_attendance
    SELECT

    @rows = NetworkEvent.
      select(select_clause).
      joins(:program, :participations).
      group('programs.name')

  end
end
