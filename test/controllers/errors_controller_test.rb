require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "should get not_found" do
    get :not_found
    assert true
    assert_response :redirect
  end

  test "should get internal_server_error" do
    get :internal_server_error
    assert true
    assert_response :redirect
  end

end
