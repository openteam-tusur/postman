class Message::Mail < Message
  def send_to(recipients)
    recipients.each { |recipient| MessageMailer.delay.send_email(subject, body, recipient) }
  end
end
