class ContactMessage < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:initialized, :sended, :received, :delivered, :failed], :default => :initialized, :predicates => true

  belongs_to :contact
  belongs_to :message
end
