class Property::Email < Property
  has_many :messages, :class_name => 'Message::Email', :foreign_key => :property_id

  validates_presence_of :url, :footer, :email
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
