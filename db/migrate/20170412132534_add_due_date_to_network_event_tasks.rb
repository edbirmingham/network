class AddDueDateToNetworkEventTasks < ActiveRecord::Migration
  def change
    add_column :network_event_tasks, :due_date, :datetime
  end
end
