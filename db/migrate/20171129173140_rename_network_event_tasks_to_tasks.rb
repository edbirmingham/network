class RenameNetworkEventTasksToTasks < ActiveRecord::Migration[5.1]
  def change
    rename_table :network_event_tasks, :tasks
  end
end
