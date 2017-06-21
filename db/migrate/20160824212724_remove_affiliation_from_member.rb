class RemoveAffiliationFromMember < ActiveRecord::Migration[5.1]
  def change
    remove_column :members, :affiliation
  end
end
