class Message < ActiveRecord::Base
  has_many :contact_messages, :dependent => :destroy
  has_many :contacts, :through => :contact_messages

  scope :ordered, -> { order('created_at') }

  normalize_attributes :subject, :body

  searchable do
    text :subject
    text :contacts, :using => :contacts_values
    string :created_at
  end

  def contacts_values
    contacts.map(&:value).join(' ')
  end

  def delivery_status_text_for(contact)
    contact_messages.find_by(:contact_id => contact.id).status_text
  end
end
