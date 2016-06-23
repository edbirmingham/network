class RemoveEventTypeFromNetworkEvents < ActiveRecord::Migration
  def up
    remove_column :network_events, :event_type, :string
  end

  def down
    add_column :network_events, :event_type, :string
  end
end
