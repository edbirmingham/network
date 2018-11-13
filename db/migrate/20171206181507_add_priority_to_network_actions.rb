class AddPriorityToNetworkActions < ActiveRecord::Migration[5.1]
  def change
    add_column :network_actions, :priority, :integer, default: 0
  end
end
