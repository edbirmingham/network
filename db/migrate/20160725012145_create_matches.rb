class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :network_action_id
      t.integer :member_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
