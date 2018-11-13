class AddSexToMemberDimension < ActiveRecord::Migration[5.2]
  def change
    add_column :member_dimensions, :sex, :string
  end
end
