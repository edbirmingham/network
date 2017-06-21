class AddDurationToNetworkEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :network_events, :duration, :integer, default: 60
  end
end
