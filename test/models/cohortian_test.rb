require 'test_helper'

class CohortianTest < ActiveSupport::TestCase
  should belong_to :member
  should belong_to :cohort
  # test "the truth" do
  #   assert true
  # end
end
