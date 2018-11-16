require 'test_helper'

class ExtracurricularActivityAssignmentTest < ActiveSupport::TestCase
  should belong_to :member
  should belong_to :extracurricular_activity
  should belong_to :user
  # test "the truth" do
  #   assert true
  # end
end
