class AddEthnicityToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :ethnicity, :string
  end
end
