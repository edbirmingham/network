class AddNotesToNetworkEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :network_events, :notes, :text
  end
end
