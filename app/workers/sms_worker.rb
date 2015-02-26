class SmsWorker
  include Sidekiq::Worker

  def perform(body, phones, slug)
    phones = phones.map { |phone| Contact::Phone.find_or_create_by :value => phone }
    property = Property::Sms.find_by(:slug => slug)
    return unless property.present?
    message = property.messages.create :body => body
    message.contacts << phones

    SendMessage.new(message).process
  end
end
