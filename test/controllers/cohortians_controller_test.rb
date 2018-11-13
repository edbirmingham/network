require 'test_helper'

class CohortiansControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
  end

  test "should create cohortian" do
    assert_difference('Cohortian.count') do
      post :create, params: {
        cohort_id: cohorts(:red).id,
        member_ids: [members(:martin).id]
      }
    end
  end

  test "should not create a duplicate cohortian" do
    assert_guard Cohortian.
      where(cohort: cohorts(:purple), member: members(:martin)).
      exists?,
      "Martin must be in the purple cohort"

    assert_no_difference('Cohortian.count') do
      post :create, params: {
        cohort_id: cohorts(:purple).id,
        member_ids: [members(:martin).id]
      }
    end

  end


  test "should go back to cohort page after creating cohortians" do
    post :create, params: {
      cohort_id: cohorts(:red).id,
      member_ids: [members(:martin).id]
    }

    assert_redirected_to cohort_path(cohorts(:red))
  end

end