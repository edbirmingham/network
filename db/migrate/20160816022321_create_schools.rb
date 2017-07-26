class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
