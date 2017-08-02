require 'test_helper'
 
class MessageMailerTest < ActionMailer::TestCase
  test "message_email sends the email" do
    email = MessageMailer.message_email("The Main Event", "subject", "the <b>body</b> <script> evil javascript </script>", ["x@x.com", "y@y.com"])
 
    assert_emails 1 do
      email.deliver_now
    end
 
    assert_equal ["no-reply@edbirmingham.com"], email.from
    assert_nil email.to
    assert_equal ["x@x.com", "y@y.com"], email.bcc
    assert_equal "subject", email.subject
    assert_equal "<p>\n  Network Event: \n</p>\n<p>\n  Subject: subject\n</p>\n<p>\n  Body: the <b>body</b>  evil javascript \n</p>\n", email.body.to_s
  end
end
