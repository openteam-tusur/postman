class MessageMailer < CommonMailer
  def send_email(subject, body, recipient, property)
    @subject   = subject
    @body      = body
    @recipient = recipient
    @property  = property

    mail(:from => 'fake@fake.fake', :to => recipient, :subject => subject)
  end
end
