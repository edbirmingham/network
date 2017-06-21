class AddMongoIdToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :mongo_id, :string
  end
end
