class MailWorker
  include Sidekiq::Worker

  sidekiq_options retry: true

  def perform(subject, body, emails_with_uuid, slug)
    emails = emails_with_uuid.map { |email, _| Contact::Email.find_or_create_by value: email }
    property = Property::Email.find_by(slug: slug)
    return unless property.present?
    message = property.messages.create subject: subject, body: body

    emails.each do |email|
      message.contact_messages.find_or_create_by contact_id: email.id, uuid: emails_with_uuid[email.value]
    end

    SendMessage.new(message).process
  end
end
