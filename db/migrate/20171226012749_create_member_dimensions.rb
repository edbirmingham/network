class CreateMemberDimensions < ActiveRecord::Migration[5.1]
  def change
    create_table :member_dimensions do |t|
      t.string :identity
      t.boolean :child_in_school_system
      t.integer :graduating_class
      t.string :school
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
