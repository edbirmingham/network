class CreateNetworkEventTasks < ActiveRecord::Migration
  def change
    create_table :network_event_tasks do |t|
      t.string :name
      t.datetime :completed_at
      t.references :common_task, index: true, foreign_key: true
      t.references :network_event, index: true, foreign_key: true
      t.integer :user_id
    end
  end
end
