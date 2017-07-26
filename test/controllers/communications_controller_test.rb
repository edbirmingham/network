require 'test_helper'

class CommunicationsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
    @communication = communications(:one)
    @member = members(:one)
  end

  test "should get new" do
    get :new, params: {  member_id: @member, id: @communication }
    assert_response :success
  end

  test "should create communication" do
    assert_difference('Communication.count') do
      post :create, params: { communication: { kind: @communication.kind, member_id: @communication.member_id, notes: @communication.notes, user_id: @communication.user_id }, member_id: @member.id, id: @communication.id }
    end

    assert_redirected_to member_communication_path(@member, assigns(:communication))
  end

  test "should show communication" do
    get :show, params: { id: @communication, member_id: @member }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @communication, member_id: @member }
    assert_response :success
  end

  test "should update communication" do
    patch :update, params: { id: @communication, communication: { kind: @communication.kind, member_id: @communication.member_id, notes: @communication.notes, user_id: @communication.user_id }, member_id: @member.id }
    assert_redirected_to member_communication_path(@member, assigns(:communication))
  end

  test "should destroy communication" do
    assert_difference('Communication.count', -1) do
      delete :destroy, params: { id: @communication, member_id: @member }
    end

    assert_redirected_to member_path
  end
end
