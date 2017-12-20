class Message < ActiveRecord::Base
  has_many :contact_messages, dependent: :destroy
  has_many :contacts, through: :contact_messages

  belongs_to :property

  scope :ordered, -> { order('created_at') }

  normalize_attributes :subject, :body

  searchable do
    text :subject
    text :contacts, using: :contacts_values
    string :created_at
    text :body, boost: 2.0
    text(:status_text) { contacts.map(&:status_text).uniq.join(' ') }
  end

  def contacts_values
    contacts.map(&:value).join(' ')
  end

  def delivery_status_text_for(contact)
    contact_messages.find_by(contact_id: contact.id).status_text
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
