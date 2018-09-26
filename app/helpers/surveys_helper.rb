module SurveysHelper
  def recipient_name(recipient)
    if recipient[:last_name].present? || recipient[:first_name].present?
      name = [recipient[:last_name], recipient[:first_name]].join(', ')
    else
      name = ""
    end
    
    if recipient[:custom_fields].present?
      member_id = recipient[:custom_fields][:"1"]
      link_to name, member_path(member_id) 
    else
      name
    end
  end
end
