class MessageMailer < ActionMailer::Base
  def message_email(network_event, subject, body, sender, recipients)
    @network_event = network_event
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
