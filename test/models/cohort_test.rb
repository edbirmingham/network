require 'test_helper'

class CohortTest < ActiveSupport::TestCase
  # should validate :name, presence: true
  # should validate_uniqueness_of :name
  # should belong_to :user
  # should have_many :cohortians
  # should have_many :cohorts, through: :cohortians
  test "should not save without name" do
    cohort = Cohort.new
    assert_not cohort.save
  end
end
