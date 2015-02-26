class Property::Sms < Property
  has_many :messages, :class_name => 'Message::Sms', :foreign_key => :property_id
end
