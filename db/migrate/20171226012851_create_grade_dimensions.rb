class CreateGradeDimensions < ActiveRecord::Migration[5.1]
  def change
    create_table :grade_dimensions do |t|
      t.integer :number
      t.string :nth
      t.string :name
    end
  end
end
