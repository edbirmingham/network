class AddOrgToEvent < ActiveRecord::Migration
  def change
    add_column :network_events, :organization_id, :integer
  end
end
