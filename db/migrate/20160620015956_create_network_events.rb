class CreateNetworkEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :network_events do |t|
      t.string :name
      t.string :event_type
      t.integer :location_id
      t.datetime :scheduled_at
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
