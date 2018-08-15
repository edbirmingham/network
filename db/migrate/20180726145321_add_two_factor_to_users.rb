class AddTwoFactorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :two_factor_auth, :boolean, default: false
  end
end
