class AddMongoIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :mongo_id, :string
  end
end
