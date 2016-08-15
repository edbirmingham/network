class RemoveOrganizationFromEvent < ActiveRecord::Migration
  def change
    remove_column :network_events, :organization_id
  end
end
