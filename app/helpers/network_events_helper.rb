module NetworkEventsHelper

  def default_start_date
    if params[:start_date].present?
      params[:start_date]
    else
      Date.today
    end
  end

  def default_end_date
    if params[:end_date].present?
      params[:end_date]
    else
      3.months.from_now
    end
  end

  def event_button_name(event)
    if event.new_record?
      'Create Event'
    else
      'Update Event'
    end
  end
  
  def clip_from(event_list)
    names = ""
    if event_list.present?
      for item in event_list
        names += item.name + ", "
      end
    end
    names.chomp(', ')
  end 
  
  def clip_event_info(event)
    if event.scheduled_at.present?
      event_schedule_time = event.try(:scheduled_at).to_formatted_s(:long)
      ends_at = (event.scheduled_at + event.duration.minutes).to_formatted_s(:long)
    else
      event_schedule_time = "Unscheduled"
      ends_at = "Unscheduled"
    end
    
    event_info = "Name: " + event.name + "\n" + 
                "Program: " + event.program.name + "\n" +
                "Location: " + event.location.name + "\n" +
                "Organizations: " + clip_from(event.organizations) + "\n" +
                "Site Contacts: " + clip_from(event.site_contacts) + "\n" +
                "School Contacts: " + clip_from(event.school_contacts) + "\n" + 
                "Volunteers: " + clip_from(event.volunteers) + "\n" +
                "Schools: " + clip_from(event.schools) + "\n" + 
                "Graduating Classes: " + clip_from(event.graduating_classes) + "\n" + 
                "Cohorts: " + clip_from(event.cohorts) + "\n" +
                "Scheduled at: " + event_schedule_time + "\n" + 
                "Ends at: " + ends_at + "\n" +
                "Notes: " + event.try(:notes).to_s
    return event_info
  end
  
  def download_query_params
    request.query_parameters.slice(
      :start_date,
      :end_date,
      :program_ids,
      :school_ids,
      :organization_ids,
      :cohort_ids,
      :graduating_class_ids)
  end
end
