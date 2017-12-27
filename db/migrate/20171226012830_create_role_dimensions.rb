class CreateRoleDimensions < ActiveRecord::Migration[5.1]
  def change
    create_table :role_dimensions do |t|
      t.string :name
    end
  end
end
