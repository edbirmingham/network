require 'test_helper'

class Reports::StudentsByProgramControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
