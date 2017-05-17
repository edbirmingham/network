module MembersHelper
  def members_download_query_params
    request.query_parameters.slice(:q, :school_ids, :identity_ids)
  end
end
