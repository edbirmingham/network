require 'test_helper'

class ProgramsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @program = programs(:network_night)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program" do
    assert_difference('Program.count') do
      post :create, params: { program: { name: @program.name + 'test', user_id: @program.user_id } }
    end

    assert_redirected_to program_path(assigns(:program))
  end

  test "should show program" do
    get :show, params: { id: @program }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @program }
    assert_response :success
  end

  test "should update program" do
    patch :update, params: { id: @program, program: { name: @program.name + 'test', user_id: @program.user_id } }
    assert_redirected_to program_path(assigns(:program))
  end

  test "should destroy program" do
    assert_difference('Program.count', -1) do
      delete :destroy, params: { id: @program }
    end

    assert_redirected_to programs_path
  end
end
