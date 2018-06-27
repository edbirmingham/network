class AddRelativePhoneToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :relative_phone, :string
  end
end
