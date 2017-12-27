class RemoveIndicators < ActiveRecord::Migration[5.1]
  def change
    remove_column :date_dimensions, :summer_indicator, :string
    remove_column :date_dimensions, :holiday_indicator, :string
  end
end
