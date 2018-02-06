require 'test_helper'

class NetworkActionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @network_action = network_actions(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:network_actions)
  end
  
  test "should filter actions to actor" do
    get :index, params: {
      owner_ids: "jane.doe@example.com",
      commit: "Filter By Actor"
    }
    assert_response :success
    assert assigns(:network_actions).present?
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network_action" do
    assert_difference('NetworkAction.count') do
      post :create, params: { network_action: { action_type: @network_action.action_type, actor_id: @network_action.actor_id, description: @network_action.description, network_event_id: @network_action.network_event_id, user_id: @network_action.user_id } }
    end

    assert_redirected_to network_action_path(assigns(:network_action))
  end

  test "should show network_action" do
    get :show, params: { id: @network_action }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @network_action }
    assert_response :success
  end

  test "should update network_action" do
    patch :update, params: { id: @network_action, network_action: { action_type: @network_action.action_type, actor_id: @network_action.actor_id, description: @network_action.description, network_event_id: @network_action.network_event_id, user_id: @network_action.user_id } }
    assert_redirected_to network_action_path(assigns(:network_action))
  end

  test "should destroy network_action" do
    assert_difference('NetworkAction.count', -1) do
      delete :destroy, params: { id: @network_action }
    end

    assert_redirected_to network_actions_path
  end
  
  test "staff user shouldn't be able to delete network_action" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @network_action
  end
end
