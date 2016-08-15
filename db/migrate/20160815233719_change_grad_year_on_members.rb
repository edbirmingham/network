class ChangeGradYearOnMembers < ActiveRecord::Migration
  def change
    rename_column :members, :graduation_year, :graduating_class_id
  end
end
