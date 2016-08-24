class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :level
      t.integer :member_id
      t.integer :network_event_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
