class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.references :owner, index: true, foreign_key: { to_table: :users }
      t.timestamps null: false
    end
  end
end
