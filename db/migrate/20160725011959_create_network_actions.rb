class CreateNetworkActions < ActiveRecord::Migration[5.1]
  def change
    create_table :network_actions do |t|
      t.integer :actor_id
      t.integer :network_event_id
      t.string :action_type
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
