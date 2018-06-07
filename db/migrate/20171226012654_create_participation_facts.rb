class CreateParticipationFacts < ActiveRecord::Migration[5.1]
  def change
    create_table :participation_facts do |t|
      t.integer :participation_id
      t.integer :date_dimension_id, null: false
      t.integer :member_dimension_id, null: false
      t.integer :event_dimension_id, null: false
      t.integer :role_dimension_id, null: false
      t.integer :grade_dimension_id, null: false

      t.integer :invited_count, null: false
      t.integer :attended_count, null: false
      t.float :hours, null: false
    end

    add_index :participation_facts, :date_dimension_id
    add_index :participation_facts, :member_dimension_id
    add_index :participation_facts, :event_dimension_id
    add_index :participation_facts, :role_dimension_id
    add_index :participation_facts, :grade_dimension_id
  end
end
