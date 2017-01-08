class AddMongoIdToNetworkEvent < ActiveRecord::Migration
  def change
    add_column :network_events, :mongo_id, :string
  end
end
