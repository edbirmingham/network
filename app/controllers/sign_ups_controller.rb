class SignUpsController < ApplicationController
  
  def index
    @network_events = NetworkEvent.where(scheduled_at: Date.today..1.week.from_now)
  end
  
  def new
    @network_event = NetworkEvent.find(params[:network_event_id])
    @member = Member.new
    @level = params[:level]
  end 

  def create
    @network_event = NetworkEvent.find(params[:network_event_id])
    @member = Member.new(member_params)
    @member.user = current_user
    member_level = params[:level]
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
  
  def update
  end
  
  private
  
  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :phone, :email)
  end
end
