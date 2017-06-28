class AddSchoolIdToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :school_id, :integer
  end
end
