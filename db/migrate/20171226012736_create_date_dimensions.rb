class CreateDateDimensions < ActiveRecord::Migration[5.1]
  def change
    create_table :date_dimensions do |t|
      t.date :date
      t.string :full_date_description
      t.string :day_of_week
      t.integer :day_number_in_calendar_month
      t.integer :day_number_in_calendar_year
      t.integer :day_number_in_school_year
      t.date :calendar_week_beginning_date
      t.integer :calendar_week_number_in_year
      t.string :calendar_month_name
      t.integer :calendar_month_number_in_year
      t.string :calendar_year_month
      t.string :calendar_year_quarter
      t.integer :calendar_quarter
      t.integer :calendar_year_half
      t.integer :calendar_year
      t.integer :school_week_number_in_year
      t.integer :school_month_number_in_year
      t.string :school_year_month
      t.string :school_year_quarter
      t.integer :school_quarter
      t.integer :school_year_half
      t.integer :school_year
      t.string :holiday_indicator
      t.string :summer_indicator
      t.string :weekday_indicator
    end
  end
end
