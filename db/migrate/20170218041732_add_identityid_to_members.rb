class AddIdentityidToMembers < ActiveRecord::Migration[5.1]
  def change
    add_reference :members, :identity, index: true, foreign_key: true
  end
end
