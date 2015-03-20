class SmsWorker
  include Sidekiq::Worker

  def perform(body, phones_with_uuid, slug)
    phones = phones_with_uuid.map { |phone, _| Contact::Phone.find_or_create_by :value => phone }
    property = Property::Sms.find_by(:slug => slug)
    return unless property.present?
    message = property.messages.create :body => body

    phones.each do |phone|
      message.contact_messages.find_or_create_by :contact_id => phone.id, :uuid => phones_with_uuid[phone.value]
    end

    SendMessage.new(message).process
  end
end
