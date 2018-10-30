require 'test_helper'

class ETLDimensionsDateTest < ActiveSupport::TestCase
  def setup
    Etl::Dimensions::Date.run

    @test_date = '2016-08-01'.to_date
    @test_date_dimension = DateDimension.where(date: @test_date).first
  end

  test 'Date dimension ETL is idempotent' do
    original = DateDimension.where(date: @test_date).all.to_a
    Etl::Dimensions::Date.run

    assert_equal original, DateDimension.where(date: @test_date).all.to_a
  end

  test 'A date is created for each day between the first and last event' do
    min_date = NetworkEvent.minimum(:scheduled_at)
    max_date = NetworkEvent.maximum(:scheduled_at)
    days = (((max_date - min_date) / 1.day) + 1).floor

    assert_equal days, DateDimension.where.not(date: nil).count
  end

  test 'No date is created before zero day' do
    minimum_date = DateDimension.where.not(date: nil).order(:date).first
    minimum_date.delete
    
    zero_day = minimum_date.date + 1.day
    Etl::Dimensions::Date.run zero_day: zero_day
    
    new_minimum_date = DateDimension.where.not(date: nil).order(:date).first
    assert_equal zero_day, new_minimum_date.date
  end
  
  test 'No date is created beyond the future window' do
    maximum_date = DateDimension.where.not(date: nil).order(date: :desc).first
    maximum_date.delete
    
    future_window = maximum_date.date - 1.day
    Etl::Dimensions::Date.run future_window: future_window
    
    new_maximum_date = DateDimension.where.not(date: nil).order(date: :desc).first
    assert_equal future_window, new_maximum_date.date
  end
  
  test 'A date is created for a missing date' do
    assert_equal 1, DateDimension.where(date: nil).count
  end

  test 'A date is created for 8/1/2016' do
    assert_equal @test_date, @test_date_dimension.date
  end

  test 'A full date description is created for 8/1/2016' do
    assert_equal 'August 1, 2016', @test_date_dimension.full_date_description
  end

  test 'A day of week is created for 8/1/2016' do
    assert_equal 'Monday', @test_date_dimension.day_of_week
  end

  test 'A day number in calendar month is created for 8/1/2016' do
    assert_equal 1, @test_date_dimension.day_number_in_calendar_month
  end

  test 'A day number in calendar year is created for 8/1/2016' do
    assert_equal 214, @test_date_dimension.day_number_in_calendar_year
  end

  test 'A day number in school_year is created for 8/1/2016' do
    assert_equal 32, @test_date_dimension.day_number_in_school_year
  end

  test 'A day number in school_year is created for 6/28/2016' do
    date = '2016-06-28'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal 364, date_dimension.day_number_in_school_year
  end

  test 'A calendar week beginning date is created for 8/1/2016' do
    assert_equal @test_date, @test_date_dimension.calendar_week_beginning_date
  end

  test 'A calendar week beginning date is created for 7/29/2016' do
    date = '2016-07-29'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal '2016-07-25'.to_date, date_dimension.calendar_week_beginning_date
  end

  test 'A calendar week number in year is created for 8/1/2016' do
    assert_equal 31, @test_date_dimension.calendar_week_number_in_year
  end

  test 'A calendar month name is created for 8/1/2016' do
    assert_equal 'August', @test_date_dimension.calendar_month_name
  end

  test 'A calendar month number in year is created for 8/1/2016' do
    assert_equal 8, @test_date_dimension.calendar_month_number_in_year
  end

  test 'A calendar year month is created for 8/1/2016' do
    assert_equal '2016-08', @test_date_dimension.calendar_year_month
  end

  test 'A calendar quarter is created for 8/1/2016' do
    assert_equal 3, @test_date_dimension.calendar_quarter
  end

  test 'A calendar year quarter is created for 8/1/2016' do
    assert_equal '2016 Q3', @test_date_dimension.calendar_year_quarter
  end

  test 'A calendar year half is created for 8/1/2016' do
    assert_equal 2, @test_date_dimension.calendar_year_half
  end

  test 'A calendar year is created for 8/1/2016' do
    assert_equal 2016, @test_date_dimension.calendar_year
  end

  test 'A school week number in year is created for 8/1/2016' do
    assert_equal 6, @test_date_dimension.school_week_number_in_year
  end

  test 'A school year is created for 8/1/2016' do
    assert_equal '2016-2017', @test_date_dimension.school_year
  end

  test 'A school year is created for 6/1/2016' do
    date = '2016-06-01'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal '2015-2016', date_dimension.school_year
  end

  test 'A school year number is created for 8/1/2016' do
    assert_equal 2016, @test_date_dimension.school_year_number
  end

  test 'A school month number in year is created for 8/1/2016' do
    assert_equal 2, @test_date_dimension.school_month_number_in_year
  end

  test 'A school month number in year is created for 6/1/2016' do
    date = '2016-06-01'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal 12, date_dimension.school_month_number_in_year
  end

  test 'A school year month is created for 8/1/2016' do
    assert_equal '2016-2017 M2', @test_date_dimension.school_year_month
  end

  test 'A school quarter is created for 8/1/2016' do
    assert_equal 1, @test_date_dimension.school_quarter
  end

  test 'A school year quarter is created for 8/1/2016' do
    assert_equal '2016-2017 Q1', @test_date_dimension.school_year_quarter
  end

  test 'A school year half is created for 8/1/2016' do
    assert_equal 1, @test_date_dimension.school_year_half
  end

  test 'A school year half is created for 6/1/2016' do
    date = '2016-06-01'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal 2, date_dimension.school_year_half
  end

  test 'A week day indicator is set for 8/1/2016' do
    assert_equal 'Weekday', @test_date_dimension.weekday_indicator
  end

  test 'A week day indicator is set for 7/31/2016' do
    date = '2016-07-31'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal 'Weekend', date_dimension.weekday_indicator
  end

  test 'A week day indicator is set for 7/30/2016' do
    date = '2016-07-30'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal 'Weekend', date_dimension.weekday_indicator
  end

  test 'A week day indicator is set for 7/29/2016' do
    date = '2016-07-29'.to_date
    date_dimension = DateDimension.where(date: date).first
    assert_equal 'Weekday', date_dimension.weekday_indicator
  end
end