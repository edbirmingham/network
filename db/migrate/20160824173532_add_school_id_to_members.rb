class AddSchoolIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :school_id, :integer
  end
end
