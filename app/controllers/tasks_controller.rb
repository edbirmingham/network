class TasksController < ApplicationController
  load_and_authorize_resource
  
  def create
    @task = Task.new(task_params)
    if @task.network_event.present?
      @network_event = NetworkEvent.find(params[:task][:network_event_id])
    elsif @task.project.present?
      @project = NetworkEvent.find(params[:task][:project_id])
    end
    @task.user = current_user
    respond_to do |format|
      if @task.save
        if @network_event.present?
          @network_event.apply_date_modifiers_to_tasks
        elsif @project.present?
          @project.apply_date_modifiers_to_tasks
        end
        format.js 
        # format.json { render json: { task: @task} }
        format.html { render action: 'index' }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @tasks = filtered_event_tasks.page params[:page]
    @status_filter = params[:status_filter]
    @project_filter = params[:project_filter]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
  end
  
  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.json { render json: @task }
        format.js {}
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed."}
      format.js {}
    end
  end
  
  private
  
  def filtered_event_tasks
    tasks = Task.
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
    
    # Filter tasks by whether they're attached to projects or events
    if params[:project_filter] == 'project_only'
      tasks = tasks.where.not(project_id: nil);
    elsif params[:project_filter] == 'event_only'
      tasks = tasks.where.not(network_event_id: nil)
    elsif params[:project_filter] == 'show_all'
      tasks = tasks
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
        
    # Fitler tasks by network event
    if params[:network_event_ids].present?
      tasks = tasks.
        where(:network_event_id => params[:network_event_ids])
    end
    
    # Filter by project
    if params[:project_ids].present?
      tasks = tasks.
        where(:project_id => params[:project_ids])
    end
  
    # Filter tasks by common task category
    if params[:common_task_ids].present?
      tasks = tasks.
        where(:common_task_id => params[:common_task_ids])
    end
    tasks
  end
  
  def task_params
    params.require(:task).permit(:name, :network_event_id, :common_task_id, :completed_at, :owner_id, :due_date, :date_modifier, :parent_id, :project_id) 
  end
  
end
