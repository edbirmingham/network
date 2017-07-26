class RemoveEventTypeFromNetworkEvents < ActiveRecord::Migration[5.1]
  def up
    remove_column :network_events, :event_type, :string
  end

  def down
    add_column :network_events, :event_type, :string
  end
end
