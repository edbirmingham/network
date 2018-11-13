class CreateProgrammingFacts < ActiveRecord::Migration[5.1]
  def change
    create_table :programming_facts do |t|
      t.integer :network_event_id
      t.integer :date_dimension_id
      t.integer :event_dimension_id
      t.integer :event_count
      t.float :hours
      t.integer :invitee_count
      t.integer :attendee_count

      t.timestamps
    end
  end
end
