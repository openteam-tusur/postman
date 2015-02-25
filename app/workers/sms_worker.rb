class SmsWorker
  include Sidekiq::Worker

  def perform(body, phones)
    phones = phones.map { |phone| Contact::Phone.find_or_create_by :value => phone }
    message = Message::Sms.create :body => body
    message.contacts << phones

    SendMessage.new(message).process
  end
end
