class NetworkEventTasksController < ApplicationController
  
  def update
    @network_event_task = NetworkEventTask.find(params[:id])
    respond_to do |format|
      if @network_event_task.update(network_event_task_params)
        format.js {}
      else
        console.log("failure")
      end
    end 
  end
  
  private
  
  def network_event_task_params
    params.require(:network_event_task).permit(:id, :name, :network_event_id, :common_task_id, :completed_at) 
  end
  
end
