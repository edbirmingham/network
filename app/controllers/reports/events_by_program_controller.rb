class Reports::EventsByProgramController < ApplicationController
  def index
    sql = <<-SQL
    SELECT
      date_dimensions.school_year,
      event_dimensions.program AS name_of_program,
      SUM(programming_facts.event_count) AS event_count,
      SUM(programming_facts.hours) AS programming_hours,
      AVG(CASE
        WHEN programming_facts.invitee_count > 0 THEN
          (programming_facts.attendee_count / programming_facts.invitee_count) * 100
        ELSE NULL
      END) AS attendance
    FROM programming_facts
      INNER JOIN date_dimensions ON date_dimensions.id = programming_facts.date_dimension_id
      INNER JOIN event_dimensions ON event_dimensions.id = programming_facts.event_dimension_id
    GROUP BY date_dimensions.school_year, event_dimensions.program
    ORDER BY date_dimensions.school_year, event_dimensions.program
    SQL

    @rows = ProgrammingFact.find_by_sql(sql)

  end
end
