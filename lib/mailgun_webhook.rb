class MailgunWebhook
  def initialize(hash)
    @hash = hash
    @contact_message = ContactMessage.find(hash['contact_message_id'])
    @event = hash['event']
  end

  def perform
    return if @contact_message.blank? || @event.blank?

    case @event
    when 'deliver'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :received
      )
    when 'open' || 'click'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :delivered
      )
    when 'bounce' || 'spam_complaint' || 'policy_rejection' || 'generation_failure' || 'generation_rejection'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :failed
      )
    when 'spam' || 'unsubscribe'
      @contact_message.update_attributes!(
        raw_email_status: hash.serialized_hash,
        status: :spam
      )
    end
  end
end
