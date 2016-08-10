class CreateGraduatingClasses < ActiveRecord::Migration
  def change
    create_table :graduating_classes do |t|
      t.integer :year
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
