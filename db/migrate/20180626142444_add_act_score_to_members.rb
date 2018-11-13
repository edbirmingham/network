class AddActScoreToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :act_score, :integer
  end
end
