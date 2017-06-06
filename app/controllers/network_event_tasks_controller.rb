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
  
  def update
    @network_event_task = NetworkEventTask.find(params[:id])
    respond_to do |format|
      if @network_event_task.update(network_event_task_params)
        format.js {}
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
  
  def network_event_task_params
    params.require(:network_event_task).permit(:name, :network_event_id, :common_task_id, :completed_at, :owner_id, :due_date, :date_modifier) 
  end
  
end
