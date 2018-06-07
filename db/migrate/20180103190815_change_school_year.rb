class ChangeSchoolYear < ActiveRecord::Migration[5.1]
  def change
    change_column :date_dimensions, :school_year, :string
    add_column :date_dimensions, :school_year_number, :integer
  end
end
