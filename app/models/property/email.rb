class Property::Email < Property
  has_many :messages, :class_name => 'Message::Email', :foreign_key => :property_id

  validates_presence_of :url, :footer
end
