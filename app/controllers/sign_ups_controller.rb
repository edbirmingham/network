class SignUpsController < ApplicationController
  
  def index
    @network_events = NetworkEvent.where(scheduled_at: Date.today..1.week.from_now)
  end
  
  def new
    @network_event = NetworkEvent.find(params[:network_event_id])
    @participation = Participation.new(:level => params[:level])
    @member = Member.new
    @searched = false
    @level = params[:level]
  end 

  def create
    @network_event = NetworkEvent.find(params[:network_event_id])
    @member = Member.new
    if params[:commit] == "Confirm attendance"
      member_level = participation_params[:level]
      @level = ""
      @participation = Participation.new(member_id: participation_params[:member_id], network_event_id: @network_event.id, level: participation_params[:level])
      respond_to do |format|
        if @participation.save
          format.html { redirect_to action: 'new', level: member_level}
          format.json { render @participation}
        else
          format.html { render :new}
          format.json { render json: @participation.errors, status: :unprocessable_entity}
        end
      end
    elsif params[:commit] == "Create Member"
      member_level = params[:level]
      @member = Member.new(member_params)
      @member.user = current_user
      respond_to do |format|
        if @member.save
          participation = Participation.new(member_id: @member.id, network_event_id: @network_event.id, level: params[:level])
          participation.save
          flash[:sign_up_success] = 'Member was created successfully'
          format.html { redirect_to action: 'new', level: member_level}
          format.json { render @member}
        else
          format.html { render :new}
          format.json { render json: @member.errors, status: :unprocessable_entity}
        end
      end
     
    end
  end
  
  def update
  end
  
  private
  
  def member_params
    params.permit(member: [:id, :first_name, :last_name, :phone, :email, :identity, :school_id, :graduating_class_id])[:member]
  end
  
  def participation_params
    params.permit(participation: [:member_id, :level])[:participation]
  end
end
