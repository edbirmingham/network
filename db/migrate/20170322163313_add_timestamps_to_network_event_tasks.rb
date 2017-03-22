class AddTimestampsToNetworkEventTasks < ActiveRecord::Migration
  def change
    add_column :network_event_tasks, :created_at, :datetime
    add_column :network_event_tasks, :updated_at, :datetime
  end
end
