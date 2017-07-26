class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
