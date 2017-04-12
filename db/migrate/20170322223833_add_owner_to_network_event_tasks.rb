class AddOwnerToNetworkEventTasks < ActiveRecord::Migration
  def change
    add_reference :network_event_tasks, :owner, index: true, foreign_key: true
  end
end
