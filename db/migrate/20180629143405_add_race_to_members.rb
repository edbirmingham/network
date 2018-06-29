class AddRaceToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :race, :string
  end
end
