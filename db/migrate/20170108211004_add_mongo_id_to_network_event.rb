class AddMongoIdToNetworkEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :network_events, :mongo_id, :string
  end
end
