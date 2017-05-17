class AddDateModifierToNetworkEventTasks < ActiveRecord::Migration
  def change
    add_column :network_event_tasks, :date_modifier, :string
  end
end
