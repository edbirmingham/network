class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = filtered_members.page params[:page]
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    @member.user = current_user
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
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

      # limit the size of xml_http_request? responses
      if request.xhr?
        members = members.limit(25)
      end

      # Filter members by search term
      if params[:q].present?
        members = members.search(params[:q])
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
      params.require(:member).permit(:first_name, :last_name, :phone, :email, :identity, :affiliation, :address, :city, :state, :zip_code, :shirt_size, :shirt_received, :place_of_worship, :recruitment, :community_networks, :extra_groups, :other_networks, :graduating_class_id, :school_id, :identity_id, :organization_ids => [], :neighborhood_ids => [], :extracurricular_activity_ids => [], talent_ids: [], :cohort_ids => [])
    end
end
