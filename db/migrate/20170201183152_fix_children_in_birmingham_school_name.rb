class FixChildrenInBirminghamSchoolName < ActiveRecord::Migration
  def change
    rename_column :members, :children_in_school, :children_in_birmingham_school
  end
end
