class MailgunWebhook
  def initialize(hash)
    @hash = hash
    @contact_message = ContactMessage.find(hash['contact_message_id']) rescue nil
    @event = hash['event']
  end

  def perform
    return if @contact_message.blank? || @event.blank?

    case @event
    when 'delivered'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :received
      )
    when 'opened' || 'clicked'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :delivered
      )
    when 'dropped' || 'bounced'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :failed
      )
    when 'complained' || 'unsubscribed'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :spam
      )
    end
  end
end
