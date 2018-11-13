class CreateAdhocRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :adhoc_recipients do |t|
      t.string :email, null: false, index: true
      t.timestamps
    end
  end
end
