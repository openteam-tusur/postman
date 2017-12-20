class Message::Email < Message
  validates_presence_of :subject, :body

  def send_to(recipients)
    recipients.each { |recipient| MessageMailer.delay.send_email(subject, body, recipient.value, recipient.contact_message_id, property) }
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
