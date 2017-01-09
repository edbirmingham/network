class CheckInsController < ApplicationController
  
  def index
    @network_events = NetworkEvent.where(scheduled_at: Date.today..2.weeks.from_now)
  end

  def new
    @level = params[:level]
    @network_event = NetworkEvent.find(params[:network_event_id])
    @network_event_id = @network_event.id 
    invitees = @network_event.invitees.sort_by(&:first_name)
    @members = []
    for invitee in invitees
      if not Participation.where(member_id: invitee.id, network_event_id: @network_event.id).present? 
        @members.push(invitee) 
      end
    end
  end

  def create
    @participation = Participation.new(participation_params)
    @participation.user = current_user
    respond_to do |format| 
        if @participation.save
            format.json { head :no_content} 
            format.html { render :nothing => true, :notice => 'Check In Successful!' } 
        else 
            format.json { render :json => current_user.errors, :status => :unprocessable_entity } 
            format.html { render :action => "edit" } 
        end 
    end  
  end
  
  private
  
  def participation_params
    params.require(:participation).permit(:member_id, :level, :network_event_id)
  end
  
end