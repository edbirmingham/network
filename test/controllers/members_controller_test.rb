require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

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
      post :create, params: { member: { address: @member.address, city: @member.city, community_networks: @member.community_networks, email: @member.email, extra_groups: @member.extra_groups, first_name: @member.first_name, identity_id: @member.identity_id, last_name: @member.last_name, other_networks: @member.other_networks, phone: @member.phone, place_of_worship: @member.place_of_worship, recruitment: @member.recruitment, shirt_received: @member.shirt_received, shirt_size: @member.shirt_size, state: @member.state, user_id: @member.user_id, zip_code: @member.zip_code } }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, params: { id: @member }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @member }
    assert_response :success
  end

  test "should update member" do
    patch :update, params: { id: @member, member: { address: @member.address, city: @member.city, community_networks: @member.community_networks, email: @member.email, extra_groups: @member.extra_groups, first_name: @member.first_name, identity_id: @member.identity_id, last_name: @member.last_name, other_networks: @member.other_networks, phone: @member.phone, place_of_worship: @member.place_of_worship, recruitment: @member.recruitment, shirt_received: @member.shirt_received, shirt_size: @member.shirt_size, state: @member.state, user_id: @member.user_id, zip_code: @member.zip_code } }
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, params: { id: @member }
    end

    assert_redirected_to members_path
  end

  test "should get members for carver school" do
     get :index,
      params: { school_ids: [@member.school.id],
      commit: "Filter members" }
    assert_response :success
    assert assigns(:members).present?
    assert_equal 2, assigns(:members).length
  end

  test "should get members for carver and tuggle school" do
     tuggle = schools(:tuggle)
     school_ids = [@member.school.id, tuggle.id]
     get :index,
      params: { school_ids: school_ids,
      commit: "Filter members" }
    assert_response :success
    assert assigns(:members).present?
    assert_equal 3, assigns(:members).length
    assert_select 'a.btn__download' do |elements|
      assert_equal 1, elements.count, "expected to find only 1 element btn__download"
      elements.each do |element|
        download_params = Rack::Utils.parse_query URI(element[:href]).query
        expected = {"school_ids[]"=> school_ids.map(&:to_s) }
        assert_equal expected, download_params
      end
    end
  end

  test "should get members with identity one or two" do
     identity_ids = [identities(:student).id, identities(:two).id]
     get :index,
      params: { identity_ids: identity_ids,
      commit: "Filter members" }
    assert_response :success
    assert assigns(:members).present?
    assert_equal 2, assigns(:members).length
    assert_select 'a.btn__download' do |elements|
      assert_equal 1, elements.count, "expected to find only 1 element btn__download"
      elements.each do |element|
        download_params = Rack::Utils.parse_query URI(element[:href]).query
        expected = {"identity_ids[]"=> identity_ids.map(&:to_s) }
        assert_equal expected, download_params
      end
    end
  end

  test "filtering by organization_ids returns the matching members" do
    organization = organizations(:one)

    @member.organizations << organization

    get :index, params: { organization_ids: [organization.id.to_s] }

    assert_response :success
    assert assigns(:members) == [@member]
  end

  test "filtering by neighborhood returns matching members" do
    neighborhood = neighborhoods(:one)

    @member.neighborhoods << neighborhood

    get :index, params: { neighborhood_ids: [neighborhood.id.to_s] }

    assert_response :success
    assert assigns(:members) == [@member]
  end

  test "should get members by graduating class of 2017" do
    get :index, params: { graduating_class_ids: [graduating_classes(:class_of_2016).id] }

    assert_response :success
    assert assigns(:members) == [@member]
  end

  test "should get members with blue cohort" do
    blue_cohort = cohorts(:blue)
    @member.cohorts << blue_cohort
    get :index, params: {
      cohort_ids: [cohorts(:blue).id]
    }

    assert_response :success
    assert assigns(:members) == [@member]
  end

  test "should get JSON index" do
    get :index, format: :json
    assert_response :success
  end

  test "should get JSON Array from index" do
    get :index, format: :json
    json = JSON.parse(response.body)
    assert json.is_a? Array
  end

  test "should get JSON Array from index with an id attribute" do
    get :index, format: :json
    json = JSON.parse(response.body)
    assert json.first.key? "id"
  end

  test "should get JSON Array from index with an text attribute" do
    get :index, format: :json
    json = JSON.parse(response.body)
    assert json.first.key? "text"
  end

  test "should get JSON Array from index with text attribute of name" do
    get :index, format: :json
    json = JSON.parse(response.body)
    member = json.first
    assert member["text"] = Member.find(member["id"]).name
  end

  test "should get JSON Array from index with text attribute of name and cohorts" do
    assert_guard Cohortian.
      where(cohort: cohorts(:purple), member: members(:martin)).
      exists?,
      "Martin must be in the purple cohort"

    get :index,
      format: :json,
      params: { cohort_ids: [cohorts(:purple).id], include: 'cohorts' }

    json = JSON.parse(response.body)
    member_json = json.first
    member = Member.find(member_json["id"])
    member_text = "#{member.name} (#{member.cohorts.map(&:name).join(',')})"

    assert_equal member_text, member_json["text"]
  end

  test "should get JSON Array from index with text attribute without parenthesis" do
    assert_guard Cohortian.where(member: members(:george)).none?,
      "George must not be in a cohort"

    get :index,
      format: :json,
      params: { include: 'cohorts' }

    json = JSON.parse(response.body)
    member_json = json.select{|m| m["id"] == members(:george).id }.first

    assert_equal members(:george).name, member_json["text"]
  end
  
  test "staff user shouldn't be able to delete members" do
    user = User.create!(email: 'test@example.com', staff: true, password: 'abcdef') 
    ability = Ability.new(user)
    assert ability.cannot? :delete, @member
  end

end
