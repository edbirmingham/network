class AddEthnicityToMemberDimensions < ActiveRecord::Migration[5.2]
  def change
    add_column :member_dimensions, :ethnicity, :string
  end
end
