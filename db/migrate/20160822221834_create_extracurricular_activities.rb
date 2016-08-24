class CreateExtracurricularActivities < ActiveRecord::Migration
  def change
    create_table :extracurricular_activities do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
