class MailWorker
  include Sidekiq::Worker

  def perform(subject, body, emails)
    emails = emails.map { |email| Contact::Email.find_or_create_by :value => email }
    message = Message::Email.create :subject => subject, :body => body
    message.contacts << emails

    SendMessage.new(message).process
  end
end
