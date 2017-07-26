class AddStatusToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :network_events, :status, :string
  end
end
