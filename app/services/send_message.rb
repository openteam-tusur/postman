class SendMessage < Struct.new(:message)
  def process
    recipients = message.contact_messages.joins(:contact).where(:contacts => { :status => :good }).select('contact_messages.id as contact_message_id, contacts.value')
    message.send_to recipients
  end
end
