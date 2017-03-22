class AddIdentityidToMembers < ActiveRecord::Migration
  def change
    add_reference :members, :identity, index: true, foreign_key: true
  end
end
