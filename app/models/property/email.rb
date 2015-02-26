class Property::Email < Property
  has_many :messages, :class_name => 'Message::Email', :foreign_key => :property_id
end
