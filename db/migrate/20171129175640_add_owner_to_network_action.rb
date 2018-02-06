class AddOwnerToNetworkAction < ActiveRecord::Migration[5.1]
  def change
    add_column :network_actions, :owner_id, :integer
  end
end
