require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "should not save project without name" do
    project = Project.new
    assert_not project.save
  end
  
  test "should save project with name" do
    project = Project.new(name: 'Test Project')
    assert project.save
  end
end
