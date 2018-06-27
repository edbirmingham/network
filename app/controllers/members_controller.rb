class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /members
  # GET /members.json
  def index
    @members = filtered_members
    respond_to do |format|
      format.any(:html, :json) { @members = @members.page params[:page] }
      format.csv
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  def new_in_group
    @member = Member.new
    @another_member_button = 'Create Member and Another'
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @another_member_button = 'Create Member and Another'
    @member = Member.new(member_params)
    @member.user = current_user
    respond_to do |format|
      if @member.save
        if params[:commit] == @another_member_button
          previous_member = @member
          @member = @member.dup
          @member.assign_attributes(first_name: nil, last_name: nil, email: nil,
                                    phone: nil , address: nil, city: nil, state: nil,
                                    zip_code: nil, shirt_size: nil)

          @member.cohorts = previous_member.cohorts
          @member.organizations = previous_member.organizations
          format.html { render :new_in_group }
        else
          format.html { redirect_to @member, notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        end
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

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

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(
        :first_name, 
        :last_name, 
        :date_of_birth, 
        :phone, 
        :email, 
        :identity, 
        :affiliation, 
        :address, 
        :city, 
        :state, 
        :zip_code, 
        :shirt_size, 
        :shirt_received, 
        :place_of_worship, 
        :recruitment, 
        :community_networks, 
        :extra_groups, 
        :other_networks, 
        :graduating_class_id, 
        :school_id, 
        :identity_id, 
        :high_school_gpa,
        :act_score,
        :relative_phone,
        :organization_ids => [], 
        :neighborhood_ids => [], 
        :extracurricular_activity_ids => [], 
        :talent_ids => [], 
        :cohort_ids => []
      )
    end
end
