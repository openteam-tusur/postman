class Message::Email < Message
  validates_presence_of :body

  def send_to(recipients)
    recipients.each { |recipient| MessageMailer.delay.send_email(self, recipient).deliver }
  end
end
