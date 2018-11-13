class AddRelativeEmailToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :relative_email, :string
  end
end
