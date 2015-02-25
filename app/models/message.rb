class Message < ActiveRecord::Base
  has_many :contact_messages, :dependent => :destroy
  has_many :contacts, :through => :contact_messages

  scope :ordered, -> { order('created_at') }

  def delivery_status_text_for(contact)
    contact_messages.find_by(:contact_id => contact.id).status_text
  end
end
