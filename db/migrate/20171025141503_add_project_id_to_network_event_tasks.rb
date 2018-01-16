class AddProjectIdToNetworkEventTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_event_tasks, :project, index: true, foreign_key: true
  end
end
