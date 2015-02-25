class ContactMessage < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:sended, :delivered, :undelivered], :default => :sended, :predicates => true

  belongs_to :contact
  belongs_to :message
end
