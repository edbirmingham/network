class AddInstagramHandleToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :instagram_handle, :string
  end
end
