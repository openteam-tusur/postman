class SmsWebhook
  def initialize(data)
    @data = data.inject([]) {|a, (_,v)| a << v.split(/\n/)}
  end

  def perform
    @data.each do |value|
      if value[0] == 'sms_status' && contact_message = ContactMessage.find_by(:remote_id => value[1])
        if status = get_status(value[-1])
          contact_message.update_attribute(:status, status)
        end
      end
    end
  end

  def get_status(code)
    case code
    when '100'
      'received'
    when '101', '102'
      'remotely_sended'
    when '103'
      'delivered'
    when /10(4|5|6|7|8)/
      'failed'
    end
  end
end
