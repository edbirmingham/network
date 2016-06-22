require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "should not save location without name" do
    location = Location.new
    assert_not location.save
  end
  
  test "should save location with name" do
    location = Location.new(name: 'Test Location')
    assert location.save
  end
end
