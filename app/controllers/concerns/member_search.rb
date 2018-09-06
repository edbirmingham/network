module MemberSearch
  extend ActiveSupport::Concern
  
  #Filters
  def filtered_members
    members = Member.includes(:identity).order(:first_name, :last_name)

    if params[:identity_ids].present?
      members = Member.
      joins(:identity).
      where(identities: {id: params[:identity_ids]})
    end

    # Include cohorts to prevent n+1
    if params[:include] == 'cohorts'
      members = members.includes(:cohorts)
    end

    # limit the size of xml_http_request? responses
    if request.xhr?
      members = members.limit(25)
    end

    # Filter members by search term
    if params[:q].present?
      query = params[:q]
      if request.xhr?
        query = query[:term]
      end
      members = members.search_by_full_name(query)
    end

    # Filter members by school.
    if params[:school_ids].present?
      members = members.where(school_id: params[:school_ids])
    end

    # Filter members by organization.
    if params[:organization_ids].present?
      members = members.joins(:organizations).
        where(organizations: { id: params[:organization_ids] })
    end

    # Filter members by neighborhood.
    if params[:neighborhood_ids].present?
      members = members.joins(:neighborhoods).
        where(neighborhoods: { id: params[:neighborhood_ids] })
    end

    # Filter members by graduating class.
    if params[:graduating_class_ids].present?
      members = members.
        where(graduating_class: params[:graduating_class_ids])
    end

    # Filter members by cohort.
    if params[:cohort_ids].present?
      members = members.
        joins(:cohortians).
        where(cohortians: {cohort_id: params[:cohort_ids]})
    end

    members
  end
end