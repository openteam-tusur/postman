class MessageMailer < CommonMailer
  def send_email(msg, recipient)
    @subject   = msg.subject
    @body      = msg.body
    @recipient = recipient
    @property  = msg.property

    contact_message = ContactMessage.find_by(:message_id => msg.id)

    headers['X-MC-Metadata'] = { 'contact_message_id' => contact_message.id }.to_json

    mail(:from => msg.property.email, :to => recipient, :subject => @subject)
  end
end
