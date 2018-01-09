class AddAncestryToNetworkEventTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :network_event_tasks, :ancestry, :string
    add_index :network_event_tasks, :ancestry
  end
end
