class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :identity
      t.string :affiliation
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :shirt_size
      t.boolean :shirt_received
      t.string :talent
      t.string :place_of_worship
      t.string :recruitment
      t.string :community_networks
      t.string :extra_groups
      t.string :other_networks
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
