class RemoveTalentFromMembers < ActiveRecord::Migration[5.1]
  def change
    remove_column :members, :talent
  end
end
