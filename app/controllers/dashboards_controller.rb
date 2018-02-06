class DashboardsController < ApplicationController
  def index
    @dashboard_filter = params[:dashboard_filter]
    if @dashboard_filter.eql?('event_tasks') || @dashboard_filter.eql?(nil)
      @events = NetworkEvent.joins(:tasks)
                            .where(tasks: {owner_id: current_user.id, completed_at: nil})
                            .distinct
                            .page params[:page]
    elsif @dashboard_filter.eql?('project_tasks')
      @projects = Project.where(completed_at: nil, owner_id: current_user.id ).page params[:page]
    end
  end
end
