class Contact < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:good, :bad, :invalid], :default => :good, :predicates => true

  has_many :contact_messages, :dependent => :destroy
  has_many :messages, -> { order 'created_at desc' }, :through => :contact_messages

  normalize_attributes :value

  alias_attribute :to_s, :value

  before_save :validate_value

  self.status.values.each do |value|
    scope value.to_sym, -> { where(:status => value) }
  end

  def self.status_kinds
    status.values.map { |v| [v.to_s, v.text] }
  end
end
