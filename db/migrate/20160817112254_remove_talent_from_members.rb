class RemoveTalentFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :talent
  end
end
