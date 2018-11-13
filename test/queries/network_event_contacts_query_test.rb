require 'test_helper'

class NetworkEventContactsQueryTest < ActiveSupport::TestCase

  def execute_query(input)
    NetworkEventContactsQuery.new(@network_event.id, input).run
  end

  def name_and_email(member)
    "#{member.first_name} #{member.last_name} (#{member.email})"
  end

  setup do
    @network_event = network_events(:tuggle_network)
    @network_event.volunteers << members(:malachi)
  end

  test "returns an empty set if there are no matches" do
    assert_empty execute_query("this-should-not-match-anything")
  end

  test "returns a matching site contact record if first_name matches" do
    member = @network_event.site_contacts.first
    assert_includes execute_query(member.first_name),
      {"id" => member.id, "type" => "Site Contact", "text" => name_and_email(member)}
  end

  test "returns a matching volunteer record if first_name matches" do
    member = @network_event.volunteers.first
    assert_includes execute_query(member.first_name),
      {"id" => member.id, "type" => "Volunteer", "text" => name_and_email(member)}
  end

  test "returns a matching school contact record if last_name matches" do
    member = @network_event.school_contacts.first
    assert_includes execute_query(member.last_name),
      {"id" => member.id, "type" => "School Contact", "text" => name_and_email(member)}
  end

  test "returns a matching volunteer record if email matches" do
    member = @network_event.volunteers.first
    assert_includes execute_query(member.email),
      {"id" => member.id, "type" => "Volunteer", "text" => name_and_email(member)}
  end

  test "returns matching record based on type" do
    volunteers = @network_event.volunteers

    result = execute_query("Volun")

    volunteers.each do |volunteer|
      assert_includes result, {"id" => volunteer.id, "type" => "Volunteer", "text" => name_and_email(volunteer)}
    end
  end

end
