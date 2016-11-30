class AddFieldsToNetworkEvents < ActiveRecord::Migration
  def change
    add_column :network_events, :needs_transport, :boolean
    add_column :network_events, :transport_ordered_on, :datetime
  end
end
