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
end
