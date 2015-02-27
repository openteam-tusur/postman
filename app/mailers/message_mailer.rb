class MessageMailer < CommonMailer
  def send_email(subject, body, recipient, contact_message_id = nil, property)
    @subject   = subject
    @body      = body
    @recipient = recipient
    @property  = property

    headers['X-MC-Metadata'] = { :contact_message_id => contact_message_id}.to_json if contact_message_id

    mail(:from => 'fake@fake.fake', :to => recipient, :subject => subject)
  end
end
