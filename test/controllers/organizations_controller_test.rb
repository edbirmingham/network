require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @organization = organizations(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.where(created_by_id: users(:one).id).count') do
      post :create, params: { organization: { name: @organization.name + 'test' } }
    end

    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should show organization" do
    get :show, params: { id: @organization }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @organization }
    assert_response :success
  end

  test "should update organization" do
    patch :update, params: { id: @organization, organization: { name: @organization.name + 'test' } }
    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete :destroy, params: { id: @organization }
    end

    assert_redirected_to organizations_path
  end
  
  test "staff user shouldn't be able to delete organization" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @organization
  end
end
