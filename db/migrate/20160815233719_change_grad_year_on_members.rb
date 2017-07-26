class ChangeGradYearOnMembers < ActiveRecord::Migration[5.1]
  def change
    rename_column :members, :graduation_year, :graduating_class_id
  end
end
