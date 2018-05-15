class Reports::EventsByProgramController < ApplicationController
  def index
    sql = <<-SQL
    SELECT
        events.school_year,
        events.name_of_program,
        COUNT(events.id) AS event_count,
        SUM(events.duration * events.cohort_count) / 60 AS programming_hours
    FROM (
        SELECT
            '2017-2018'::text AS school_year,
            MAX(programs.name) AS name_of_program,
            network_events.id,
            network_events.duration,
            GREATEST(1, COUNT(cohort_assignments.id)) AS cohort_count
        FROM network_events
            INNER JOIN programs ON programs.id = network_events.program_id
            LEFT JOIN cohort_assignments ON cohort_assignments.network_event_id = network_events.id
            LEFT JOIN cohorts ON cohorts.id = cohort_assignments.cohort_id
        WHERE network_events.scheduled_at > '2017/07/01'
        GROUP BY network_events.id
    ) AS events
    GROUP BY events.school_year, events.name_of_program
    ORDER BY events.school_year, events.name_of_program
    SQL

    @rows = NetworkEvent.find_by_sql(sql)

  end
end
