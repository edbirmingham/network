# Search a network event's contacts for members by name or email
class NetworkEventContactsQuery
  include ActiveRecord::Sanitization::ClassMethods

  def initialize(network_event_id, input=nil)
    @network_event_id = network_event_id
    @input = (input.downcase << '%') if input.present?
  end

  def run
    connection.exec_query(sanitized_sql).to_hash
  end

  private

  # Needed for sanitize_sql_array
  def connection
    NetworkEvent.connection
  end

  def sanitized_sql
    sanitize_sql_array([
      sql,
      {network_event_id: @network_event_id, input: @input}
    ])
  end

  def name_and_email_sql
    "(first_name || ' ' || last_name || ' (' || COALESCE(email,'') || ')') as text"
  end

  def sql
    @sql = <<-SQL
      SELECT member_id as id, 'School Contact' as type, #{name_and_email_sql}
      FROM school_contact_assignments
      INNER JOIN members ON members.id = school_contact_assignments.member_id
      WHERE network_event_id = :network_event_id #{member_conditions('school contact')}

      UNION ALL

      SELECT member_id as id, 'Site Contact' as type, #{name_and_email_sql}
      FROM site_contact_assignments
      INNER JOIN members ON members.id = site_contact_assignments.member_id
      where network_event_id = :network_event_id #{member_conditions('site contact')}

      UNION ALL

      SELECT member_id as id, 'Volunteer' as type, #{name_and_email_sql}
      FROM volunteer_assignments
      INNER JOIN members ON members.id = volunteer_assignments.member_id
      where network_event_id = :network_event_id #{member_conditions('volunteer')}

    SQL
  end

  def member_conditions(type)
    if @input.present?
      "AND (LOWER(members.last_name) LIKE :input OR LOWER(members.first_name) LIKE :input OR LOWER(members.email) LIKE :input OR '#{type}' LIKE :input)"
    end
  end
end
