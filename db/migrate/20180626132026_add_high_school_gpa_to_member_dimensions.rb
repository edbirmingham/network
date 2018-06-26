class AddHighSchoolGpaToMemberDimensions < ActiveRecord::Migration[5.2]
  def change
    add_column :member_dimensions, :high_school_gpa, :float
  end
end
