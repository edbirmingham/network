class NetworkEventTasksController < ApplicationController
  
  def create
    @network_event_task = NetworkEventTask.new(network_event_task_params)
    @network_event = NetworkEvent.find(params[:network_event_task][:network_event_id])
    @network_event_task.user = current_user
    respond_to do |format|
      if @network_event_task.save
        @network_event.apply_date_modifiers_to_tasks
        format.js {}
      else
        format.json { render json: @network_event_task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @network_event_tasks = filtered_event_tasks.page params[:page]
    @status_filter = params[:status_filter]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
  end
  
  def update
    @network_event_task = NetworkEventTask.find(params[:id])
    respond_to do |format|
      if @network_event_task.update(network_event_task_params)
        format.json { render json: @network_event_task }
      else
        format.json { render json: @network_event_task.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def destroy
    @network_event_task = NetworkEventTask.find(params[:id])
    @network_event_task.destroy
    respond_to do |format|
      format.js {}
    end
  end
  
  private
  
  def filtered_event_tasks
    tasks = NetworkEventTask.
      includes(:owner, :network_event, :common_task).
      order("due_date IS NULL, due_date ASC")
      
    # Filter members by search term
    if params[:q].present?
      query = params[:q]
      if request.xhr?
        query = query[:term]
      end
      tasks = tasks.search_by_task_name(query)
    end
    
    # Filter tasks by completion
    if params[:status_filter] == 'uncompleted_only'
      tasks = tasks.where(completed_at: nil);
    elsif params[:status_filter] == 'completed_only'
      tasks = tasks.where.not(completed_at: nil)
    elsif params[:status_filter] == 'show_all'
      tasks = tasks
    end
    
    # Filter by due date
    if params[:start_date].present? && params[:end_date].present?
      tasks = tasks.in_date_range(params[:start_date], params[:end_date])
    end
    
    # Filter tasks by owner
    if params[:owner_ids].present?
      tasks = tasks.
        where(:owner_id => params[:owner_ids])
    end
        
    # Filter tasks by common task category
    if params[:common_task_ids].present?
      tasks = tasks.
        where(:common_task_id => params[:common_task_ids])
    end
    
    # Fitler tasks by network event
    if params[:network_event_ids].present?
      tasks = tasks.
        where(:network_event_id => params[:network_event_ids])
    end
    tasks
  end
  
  def network_event_task_params
    params.require(:network_event_task).permit(:name, :network_event_id, :common_task_id, :completed_at, :owner_id, :due_date, :date_modifier) 
  end
  
end
