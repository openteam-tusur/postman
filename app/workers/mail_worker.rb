class MailWorker
  include Sidekiq::Worker

  def perform(subject, body, emails, slug)
    emails = emails.map { |email| Contact::Email.find_or_create_by :value => email }
    property = Property::Email.find_by(:slug => slug)
    return unless property.present?
    message = property.messages.create :subject => subject, :body => body
    message.contacts << emails

    SendMessage.new(message).process
  end
end
