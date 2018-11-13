require 'test_helper'

class GraduatingClassTest < ActiveSupport::TestCase
  test "#name should be Class of <year>" do
    graduating_class = GraduatingClass.new(year: 2017)
    assert_equal "Class of 2017", graduating_class.name
  end

  test "#grade should be Alum 2" do
    Timecop.freeze(Time.local(2018, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Alum 2", graduating_class.grade
    end
  end

  test "#grade should be Alum 1" do
    Timecop.freeze(Time.local(2017, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Alum 1", graduating_class.grade
    end
  end

  test "#grade should be 12th in June of same year" do
    Timecop.freeze(Time.local(2017, 6, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "12th", graduating_class.grade
    end
  end

  test "#grade should be 12th in September of previous year" do
    Timecop.freeze(Time.local(2016, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "12th", graduating_class.grade
    end
  end

  test "#grade should be 11th" do
    Timecop.freeze(Time.local(2015, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "11th", graduating_class.grade
    end
  end

  test "#grade should be 10th" do
    Timecop.freeze(Time.local(2014, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "10th", graduating_class.grade
    end
  end

  test "#grade should be 9th" do
    Timecop.freeze(Time.local(2013, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "9th", graduating_class.grade
    end
  end

  test "#grade should be 8th" do
    Timecop.freeze(Time.local(2012, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "8th", graduating_class.grade
    end
  end

  test "#grade should be 7th" do
    Timecop.freeze(Time.local(2011, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "7th", graduating_class.grade
    end
  end

  test "#grade should be 6th" do
    Timecop.freeze(Time.local(2010, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "6th", graduating_class.grade
    end
  end

  test "#grade should be 5th" do
    Timecop.freeze(Time.local(2009, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "5th", graduating_class.grade
    end
  end

  test "#grade should be 4th" do
    Timecop.freeze(Time.local(2008, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "4th", graduating_class.grade
    end
  end

  test "#grade should be 3rd" do
    Timecop.freeze(Time.local(2007, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "3rd", graduating_class.grade
    end
  end

  test "#grade should be 2nd" do
    Timecop.freeze(Time.local(2006, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "2nd", graduating_class.grade
    end
  end

  test "#grade should be 1st" do
    Timecop.freeze(Time.local(2005, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "1st", graduating_class.grade
    end
  end

  test "#grade should be Kindergarten" do
    Timecop.freeze(Time.local(2004, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Kindergarten", graduating_class.grade
    end
  end

  test "#grade should be Pre-K4" do
    Timecop.freeze(Time.local(2003, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Pre-K4", graduating_class.grade
    end
  end

  test "#grade should be Pre-K3" do
    Timecop.freeze(Time.local(2002, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Pre-K3", graduating_class.grade
    end
  end

  test "#grade should be Pre-K2" do
    Timecop.freeze(Time.local(2001, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Pre-K2", graduating_class.grade
    end
  end

  test "#grade should be Pre-K1" do
    Timecop.freeze(Time.local(2000, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Pre-K1", graduating_class.grade
    end
  end

  test "#grade should be Pre-K0" do
    Timecop.freeze(Time.local(1999, 9, 1)) do
      graduating_class = GraduatingClass.new(year: 2017)
      assert_equal "Pre-K0", graduating_class.grade
    end
  end
end
