require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "should not save organization without name" do
    organization = Organization.new
    assert_not organization.save
  end

  test "should save organization with name" do
    organization = Organization.new(name: 'Test Organization')
    assert organization.save
  end
end
