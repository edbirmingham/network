module CommunicationsHelper
  
 def default_start_date
    if params[:contacted_on].present?
      params[:contacted_on]
    else
      Date.today
    end
  end 
end
