class AwsWebhook
  def initialize(params)
    @params = params
    contact_message_id = params.try(:mail).try(:headers).find { |hash|
      hash.name == 'X-Mailgun-Variables'
    }.try(:value)
    contact_message_id = JSON.load(contact_message_id)['contact_message_id'] rescue nil
    @contact_message = ContactMessage.find_by(id: contact_message_id)
    @event = params.notification_type
  end

  def perform
    if @contact_message
      case @event
      when 'Send'
        @contact_message.update_attributes!(
          raw_email_status: @params.to_json.try(:force_encoding,'utf-8'),
          status: :sended
        )
      when 'Delivery' || 'Open' || 'Click'
        @contact_message.update_attributes!(
          raw_email_status: @params.to_json.try(:force_encoding,'utf-8'),
          status: :delivered
        )
      when 'Bounce' || 'Reject' || 'Rendering Failure'
        @contact_message.update_attributes!(
          raw_email_status: @params.to_json.try(:force_encoding,'utf-8'),
          status: :failed
        )
      when 'Complaint'
        @contact_message.update_attributes!(
          raw_email_status: @params.to_json.try(:force_encoding,'utf-8'),
          status: :spam
        )
      else
        @contact_message.update_attributes!(
          raw_email_status: @params.to_json.try(:force_encoding,'utf-8'),
          status: :initialized
        )
      end
    end
  end
end
