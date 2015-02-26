module ApplicationHelper
  def delivery_status(message, contact)
    message.contact_messages.find_by(:contact_id => contact.id).status
  end
end
