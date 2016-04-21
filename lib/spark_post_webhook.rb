class SparkPostWebhook
  def initialize(data)
    @sparkpost_response = data

    @events = @sparkpost_response["_json"].map do |event|
      WebhookEvent.new event rescue nil
    end.compact
  end

  def perform
    @events.each do |event|
      case event.hook_type
      when 'delivery'
        event.contact_message.update_attributes!(:raw_email_status => event.serialized_hash, :status => :received)
      when 'bounce' || 'spam_complaint' || 'policy_rejection' || 'generation_failure' || 'generation_rejection'
        event.contact_message.update_attributes!(:raw_email_status => event.serialized_hash, :status => :failed)
      when 'open' || 'click'
        event.contact_message.update_attributes!(:raw_email_status => event.serialized_hash, :status => :delivered)
      end
    end
  end

  class WebhookEvent
    attr_reader :hook_type, :contact_message
    def initialize(hash)
      @type = hash['msys'].keys.first
      @hash = hash['msys'][@type]
      @hook_type = @hash['type']
      @contact_message = ContactMessage.find @hash['rcpt_meta']['contact_message_id']
    end

    def type
      @type.gsub('_event', '')
    end

    def method_missing(method)
      @hash[method]
    end

    def serialized_hash
      @hash.to_json
    end
  end
end
