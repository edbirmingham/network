class AddStatusToNetworkActions < ActiveRecord::Migration[5.1]
  def change
    add_column :network_actions, :status, :integer, default: 0
  end
end
