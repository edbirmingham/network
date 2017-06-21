class AddDueDateToNetworkEventTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :network_event_tasks, :due_date, :datetime
  end
end
