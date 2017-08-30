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
    participation_details = params[:participation]
    member_ids = participation_details[:member_ids]
    network_event_id = participation_details[:network_event_id]
    level = participation_details[:level]
    error_ids =[]
    member_ids.each do |member_id|
      participation_params = {member_id: member_id, network_event_id: network_event_id, level: level}
      @participation = Participation.new(participation_params)
      @participation.user = current_user
      error_ids << member_id unless @participation.save
    end

    respond_to do |format|
      if error_ids.empty?
        flash[:check_in_message] = "#{member_ids.size} members successfully checked in"
        format.json { head :no_content}
        format.html { render :body => nil, status: 200, :notice => 'Check In Successful!' }
      else
        flash[:check_in_message] = "Error Checking In #{error_ids.size} members"
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
