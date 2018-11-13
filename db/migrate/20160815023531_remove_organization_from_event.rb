class RemoveOrganizationFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :network_events, :organization_id
  end
end
