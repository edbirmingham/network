class AddFacebookNameToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :facebook_name, :string
  end
end
