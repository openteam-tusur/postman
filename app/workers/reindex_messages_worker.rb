class ReindexMessagesWorker
  include Sidekiq::Worker

  def perform(contact_id)
    contact = Contact.find(contact_id)
    return if contact.blank?

    messages = contact.messages
    return if messages.empty?

    messages.each do |message|
      message.index
    end

    Sunspot.commit
  end
end
