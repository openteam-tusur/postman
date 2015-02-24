class Message < ActiveRecord::Base
  has_many :contact_messages, :dependent => :destroy
  has_many :contacts, :through => :contact_messages
end
