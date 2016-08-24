class RemoveAffiliationFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :affiliation
  end
end
