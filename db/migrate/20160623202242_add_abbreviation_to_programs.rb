class AddAbbreviationToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :abbreviation, :string
  end
end
