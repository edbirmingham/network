class AddTwitterHandleToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :twitter_handle, :string
  end
end
