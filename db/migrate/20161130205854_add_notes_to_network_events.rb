class AddNotesToNetworkEvents < ActiveRecord::Migration
  def change
    add_column :network_events, :notes, :text
  end
end
