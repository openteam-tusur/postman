class MessageMailer < CommonMailer
  def send_email(msg, recipient)
    @subject   = msg.subject
    @body      = msg.body
    @recipient = recipient
    @property  = msg.property

    contact_message = Contact.find_by(:value => recipient.value).contact_messages.find_by(:message_id => msg.id)

    headers['X-MC-Metadata'] = { 'contact_message_id' => contact_message.id }.to_json

    mail(:from => msg.property.email, :to => recipient.value, :subject => @subject)
  end
end
