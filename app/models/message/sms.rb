class Message::Sms < Message
  validates_presence_of :body

  def send_to(recipients)
    if recipients.length > 100
      parts = (recipients.count / 100.0).ceil
      splited_recipients = recipients.in_groups(parts, false)

      splited_recipients.each do |group|
        self.send_to(group)
      end
    else
      recipients.each do |recipient|
        begin
          #TODO remove :test key on production
          response = SmsRu.sms.send(:text => self.body, :to => recipient.value, :from => 'TUSUR', :test => 1)
          contact_message = self.contact_messages.find(recipient.contact_message_id).tap do |cm|
            cm.update_attribute(:status, :sended)
          end

          contact_message.update_attributes(:status => :received, :remote_id => response[1]) if response
        rescue
          next
        end
      end
    end
  end
end
