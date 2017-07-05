class CreateSchoolAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :school_assignments do |t|
      t.integer :network_event_id
      t.integer :school_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
