class AddActScoreToMemberDimensions < ActiveRecord::Migration[5.2]
  def change
    add_column :member_dimensions, :act_score, :integer
  end
end
