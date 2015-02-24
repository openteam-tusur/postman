class Contact < ActiveRecord::Base
  has_many :contact_messages, :dependent => :destroy
  has_many :messages, :through => :contact_messages
end
