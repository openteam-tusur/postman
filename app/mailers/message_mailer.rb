class MessageMailer < CommonMailer
  def send_email(subject, body, recipient)
    @subject   = subject
    @body      = body
    @recipient = recipient

    mail(:from => 'fake@fake.fake', :to => recipient, :subject => subject)
  end
end
