require 'test_helper'

class NeighborhoodTest < ActiveSupport::TestCase
  test "Neighborhood should not save with name" do
    neighborhood = Neighborhood.new
    assert_not neighborhood.save
  end
  test "Neighborhood should save with name" do
    neighborhood = Neighborhood.new(name:"test neighborhood")
    assert neighborhood.save
  end
end
