module MembersHelper
  def members_search_query_params
    request.query_parameters.slice(
      :q,
      :school_ids,
      :identity_ids,
      :organization_ids,
      :cohort_ids,
      :graduating_class_ids,
      :neighborhood_ids
    )
  end
  
  def recipients_params(count)
    members_search_query_params.merge(recipients: count)
  end
end
