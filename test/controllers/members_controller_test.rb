require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @member = members(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { address: @member.address, city: @member.city, community_networks: @member.community_networks, email: @member.email, extra_groups: @member.extra_groups, first_name: @member.first_name, identity: @member.identity, last_name: @member.last_name, other_networks: @member.other_networks, phone: @member.phone, place_of_worship: @member.place_of_worship, recruitment: @member.recruitment, shirt_received: @member.shirt_received, shirt_size: @member.shirt_size, state: @member.state, user_id: @member.user_id, zip_code: @member.zip_code }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    patch :update, id: @member, member: { address: @member.address, city: @member.city, community_networks: @member.community_networks, email: @member.email, extra_groups: @member.extra_groups, first_name: @member.first_name, identity: @member.identity, last_name: @member.last_name, other_networks: @member.other_networks, phone: @member.phone, place_of_worship: @member.place_of_worship, recruitment: @member.recruitment, shirt_received: @member.shirt_received, shirt_size: @member.shirt_size, state: @member.state, user_id: @member.user_id, zip_code: @member.zip_code }
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end
