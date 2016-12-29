class AddStatusToEvent < ActiveRecord::Migration
  def change
    add_column :network_events, :status, :string
  end
end
