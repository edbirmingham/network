class MessageMailer < ActionMailer::Base
  default from: 'no-reply@edbirmingham.com'
 
  def message_email(network_event_name, subject, body, recipients)
    @network_event_name = network_event_name
    @subject = subject
    @body = body
    mail(
      bcc: Array.wrap(recipients),
      cc: "",
      subject: subject
    )
  end
end
