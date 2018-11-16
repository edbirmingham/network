require 'test_helper'

class ExtracurricularActivityTest < ActiveSupport::TestCase
  test "ExtracurricularActivity should not save without name" do
    extracurricular_activity = ExtracurricularActivity.new
    assert_not extracurricular_activity.save
  end
  test "ExtracurricularActivity should save with name" do
    extracurricular_activity = ExtracurricularActivity.new(name:"test extracurricular_activity")
    assert   extracurricular_activity.save
  end
end
