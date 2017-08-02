require 'test_helper'

class MessageFormTest < ActiveSupport::TestCase
  setup do
    @tuggle = network_events(:tuggle_network)
    message = Message.new
    @form = MessageForm.new(message)
    @form.subject = "test"
    @form.body = "test"
    @form.network_event = @tuggle
    @form.sender = users(:one)
  end

  test "can assign 'All Volunteers'" do
    @tuggle.volunteers << members(:jane)
    @form.recipient_ids = [NetworkEventContactsQuery::ALL_VOLUNTEERS.to_s]
    @form.save

    assert_equal @tuggle.volunteers, @form.model.member_recipients
  end

  test "can assign 'All Site Contacts'" do
    @tuggle.site_contacts << members(:rosa)
    @form.recipient_ids = [NetworkEventContactsQuery::ALL_SITE_CONTACTS.to_s]
    @form.save

    assert_equal @tuggle.site_contacts, @form.model.member_recipients
  end

  test "can assign 'All School Contacts'" do
    @tuggle.school_contacts << members(:carrie)
    @form.recipient_ids = [NetworkEventContactsQuery::ALL_SCHOOL_CONTACTS.to_s]
    @form.save

    assert_equal @tuggle.school_contacts, @form.model.member_recipients
  end

  test "can assign ad-hoc email addresses" do
    @form.recipient_ids = ["j@j.com"]
    @form.save

    assert_equal ["j@j.com"], @form.model.adhoc_recipients.pluck(:email)
  end

  test "can assign specific members" do
    volunteer_id = @tuggle.volunteers.last.id
    @form.recipient_ids = [volunteer_id]
    @form.save

    assert_equal [volunteer_id], @form.model.member_recipient_ids
  end
end
