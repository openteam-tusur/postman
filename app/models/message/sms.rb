class Message::Sms < Message
  validates_presence_of :subject, :body

  def send_to(recipients)
  end
end
