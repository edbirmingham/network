class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.integer :member_id
      t.integer :organization_id
      
      t.timestamps null: false
    end
  end
end
