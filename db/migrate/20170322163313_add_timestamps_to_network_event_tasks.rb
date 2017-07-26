class AddTimestampsToNetworkEventTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :network_event_tasks, :created_at, :datetime
    add_column :network_event_tasks, :updated_at, :datetime
  end
end
