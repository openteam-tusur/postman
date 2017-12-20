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
          options = { :text => self.body, :to => recipient.value, :from => 'TUSUR' }
          options.merge! :test => 1 if Rails.env.development?
          response = SmsRu.sms.send options
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

# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  subject     :string
#  body        :text
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :integer
#
