class AddHighSchoolGpaToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :high_school_gpa, :float
  end
end
