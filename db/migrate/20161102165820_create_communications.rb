class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.string :kind
      t.text :notes
      t.integer :member_id
      t.integer :user_id
      t.datetime :contacted_on

      t.timestamps null: false
    end
  end
end
