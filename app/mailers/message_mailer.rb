class MessageMailer < ActionMailer::Base
  def message_email(network_event_name, subject, body, sender, recipients)
    @network_event_name = network_event_name
    @subject = subject
    @body = body
    mail(
      from: sender.presence || 'no-reply@edbirmingham.org',
      bcc: Array.wrap(recipients),
      cc: "",
      subject: subject
    )
  end
end
