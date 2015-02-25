class Contact < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:good, :bad, :unknown], :default => :unknown, :predicates => true

  has_many :contact_messages, :dependent => :destroy
  has_many :messages, :through => :contact_messages

  self.status.values.each do |value|
    scope value.to_sym, -> { where(:status => value) }
  end
end
