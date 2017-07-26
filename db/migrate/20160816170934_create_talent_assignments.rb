class CreateTalentAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :talent_assignments do |t|
      t.integer :talent_id
      t.integer :member_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
