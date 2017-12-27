class AddMemberIdToDimension < ActiveRecord::Migration[5.1]
  def change
    add_column :member_dimensions, :member_id, :integer
  end
end
