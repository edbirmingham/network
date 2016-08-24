class CreateExtracurricularActivityAssignments < ActiveRecord::Migration
  def change
    create_table :extracurricular_activity_assignments do |t|
      t.integer :member_id
      t.integer :extracurricular_activity_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
