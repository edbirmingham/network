class AddAbbreviationToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :abbreviation, :string
  end
end
