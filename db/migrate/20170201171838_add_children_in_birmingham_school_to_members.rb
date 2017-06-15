class AddChildrenInSchoolToMembers < ActiveRecord::Migration
  def change
    add_column :members, :children_in_school, :boolean
  end
end
