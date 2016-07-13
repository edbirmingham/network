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
      Date.today + 6.days
    end
  end
  
end
