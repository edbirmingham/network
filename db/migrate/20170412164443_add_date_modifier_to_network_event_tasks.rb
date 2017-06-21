class AddDateModifierToNetworkEventTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :network_event_tasks, :date_modifier, :string
  end
end
