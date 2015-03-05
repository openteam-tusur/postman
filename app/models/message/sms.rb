class Message::Sms < Message
  validates_presence_of :body

  def send_to(recipients)
  end
end
