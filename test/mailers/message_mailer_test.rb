require 'test_helper'
 
class MessageMailerTest < ActionMailer::TestCase
  setup do
    @event = NetworkEvent.new(
      name: "The Main Event",
      program: programs(:network_night),
      location: locations(:tuggle),
      scheduled_at: DateTime.new(2018, 1, 20, 18)
    )
  end
  
  test "message_email sends the email" do
    email = MessageMailer.message_email(
      @event, 
      "subject", 
      "the <b>body</b> <script> evil javascript </script>", 
      "a@a.com",
      ["x@x.com", "y@y.com"]
    )
 
    assert_emails 1 do
      email.deliver_now
    end
 
    assert_equal ["a@a.com"], email.from
    assert_nil email.to
    assert_equal ["x@x.com", "y@y.com"], email.bcc
    assert_equal "subject", email.subject
    assert_equal read_fixture('event').join, email.body.to_s
  end
  
  test "message_email uses default email if sender does not have an email" do
    email = MessageMailer.message_email(
      @event, 
      "subject", 
      "the <b>body</b> <script> evil javascript </script>", 
      "",
      ["x@x.com", "y@y.com"]
    )
 
    assert_emails 1 do
      email.deliver_now
    end
 
    assert_equal ["no-reply@edbirmingham.org"], email.from
  end
end
