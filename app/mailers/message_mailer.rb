class MessageMailer < ActionMailer::Base
  before_filter :add_inline_attachment!

  layout 'email'

  def send_email(subject, body, recipient, contact_message_id = nil, property)
    @body     = body
    @property = property

    headers['X-MSYS-API'] = {
      options: {
        contact_message_id: contact_message_id
      },
      metadata: {
        contact_message_id: contact_message_id
      }
    }.to_json if contact_message_id

    headers['X-Mailgun-Variables'] = {
      contact_message_id: contact_message_id
    }.to_json if contact_message_id

    mail(from: property.email, to: recipient, subject: subject)
  end

  def add_inline_attachment!
    attachments.inline['logo_w.png'] = {
      content: File.read(Rails.root.join('app/assets/images/logo_w.png')),
      content_id: "<logo_w.png@#{Settings['app.host']}>"
    }
  end
end
