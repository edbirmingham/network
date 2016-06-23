require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
  test "should not save program without name" do
    program = Program.new
    assert_not program.save
  end
  
  test "should save program with name" do
    program = Program.new(name: 'Test Program')
    assert program.save
  end
end
