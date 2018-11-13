class CreateCohortians < ActiveRecord::Migration[5.1]
  def change
    create_table :cohortians do |t|
      t.integer :member_id
      t.integer :cohort_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
