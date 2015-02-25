class MessageMailer < CommonMailer
  def send_email(message, sender, recipient)
    @message   = message
    @recipient = recipient
    @sender    = sender

    mail(:from => sender.email, :to => recipient.email, :subject => message.subject)
  end
end
