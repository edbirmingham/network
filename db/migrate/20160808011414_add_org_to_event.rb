class AddOrgToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :network_events, :organization_id, :integer
  end
end
