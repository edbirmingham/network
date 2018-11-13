class AddStaffToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :staff, :boolean
  end
end
