class MandrillWebhook
  def initialize(data)
    @mandrill_response = JSON.parse(data).first rescue {}

    find_contact_message
    find_event
  end

  def perform
    case @event

    when 'send'
      @contact_message.update_attributes!(:raw_email_status => @mandrill_response, :status => :received)
    when 'hard_bounce' || 'soft_bounce' || 'spam' || 'reject'
      @contact_message.update_attributes!(:raw_email_status => @mandrill_response, :status => :failed)
    when 'open' || 'click'
      @contact_message.update_attributes!(:raw_email_status => @mandrill_response, :status => :delivered)
    end
  end

  private

  def find_contact_message
    contact_message_id = @mandrill_response.try(:[], 'msg').try(:[], 'metadata').try(:[], 'contact_message_id')

    @contact_message = ContactMessage.find_by(:id => contact_message_id)
  end

  def find_event
    @event = @mandrill_response.try(:[], 'event')
  end
end
