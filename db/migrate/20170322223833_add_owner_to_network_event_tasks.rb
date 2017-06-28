class AddOwnerToNetworkEventTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_event_tasks, :owner, index: true, foreign_key: { to_table: :users }
  end
end
