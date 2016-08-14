class CreateGraduatingClassAssignments < ActiveRecord::Migration
  def change
    create_table :graduating_class_assignments do |t|
      t.integer :graduating_class_id
      t.integer :network_event_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
