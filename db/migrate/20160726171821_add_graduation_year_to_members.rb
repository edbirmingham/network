class AddGraduationYearToMembers < ActiveRecord::Migration
  def change
    add_column :members, :graduation_year, :integer
  end
end
