class MailgunWebhook
  def initialize(hash)
    @hash = hash
    @contact_message = ContactMessage.find(@hash['contact_message_id']) rescue nil
    @event = @hash['event']
  end

  def perform
    return if @contact_message.blank? || @event.blank?

    case @event
    when 'delivered'
      @contact_message.update_attributes!(
        raw_email_status: @hash.to_json,
        status: :received
      )
    when 'opened' || 'clicked'
      @contact_message.update_attributes!(
        raw_email_status: @hash.to_json,
        status: :delivered
      )
    when 'dropped' || 'bounced'
      @contact_message.update_attributes!(
        raw_email_status: @hash.to_json,
        status: :failed
      )
    when 'complained' || 'unsubscribed'
      @contact_message.update_attributes!(
        raw_email_status: @hash.to_json,
        status: :spam
      )
    end
  end
end
