class AddNetworkEventIdToDimension < ActiveRecord::Migration[5.1]
  def change
    add_column :event_dimensions, :network_event_id, :integer
  end
end
