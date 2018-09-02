class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :surveymonkey_token, :string
    add_column :users, :surveymonkey_uid, :string
  end
end
