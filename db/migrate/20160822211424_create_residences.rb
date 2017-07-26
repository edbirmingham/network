class CreateResidences < ActiveRecord::Migration[5.1]
  def change
    create_table :residences do |t|
      t.integer :member_id
      t.integer :neighborhood_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
