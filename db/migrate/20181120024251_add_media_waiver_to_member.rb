class AddMediaWaiverToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :media_waiver, :boolean
  end
end
