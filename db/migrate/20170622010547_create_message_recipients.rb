class CreateMessageRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :message_recipients do |t|
      t.references :message, index: true, null: false
      t.integer :recipient_id, null: false
      t.string :recipient_type, null: false
      t.timestamps
      t.index [:recipient_id, :recipient_type]
    end
  end
end
