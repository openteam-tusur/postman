class SendMessage < Struct.new(:message)
  def process
    recipients = message.contacts.good
    message.send_to recipients
    message.contact_messages.update_all :status => :sended
  end
end
