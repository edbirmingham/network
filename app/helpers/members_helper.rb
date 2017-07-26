module MembersHelper
  def members_download_query_params
    request.query_parameters.slice(:q,
      :school_ids,
      :identity_ids,
      :organization_ids,
      :cohort_ids,
      :graduating_class_ids)
  end
end
