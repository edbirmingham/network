class AddDurationToNetworkEvents < ActiveRecord::Migration
  def change
    add_column :network_events, :duration, :integer, default: 60
  end
end
