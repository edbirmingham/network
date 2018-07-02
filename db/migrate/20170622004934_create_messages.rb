class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :network_event_id, null: false
      t.integer :sender_id, null: false
      t.string  :subject, null: false
      t.text    :body, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
      t.index :network_event_id
    end
  end
end
