class Property::Sms < Property
  has_many :messages, :class_name => 'Message::Sms', :foreign_key => :property_id
end

# == Schema Information
#
# Table name: properties
#
#  id         :integer          not null, primary key
#  title      :string
#  type       :string
#  url        :text
#  footer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  email      :string
#
