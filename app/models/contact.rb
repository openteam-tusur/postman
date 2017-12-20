class Contact < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:good, :bad, :invalid], :default => :good, :predicates => true

  has_many :contact_messages, :dependent => :destroy
  has_many :messages, -> { order 'created_at desc' }, :through => :contact_messages

  normalize_attributes :value, :with => [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.downcase : value
  end

  validates_uniqueness_of :value

  alias_attribute :to_s, :value

  before_save :validate_value

  after_update :reindex_messages, if: :status_changed?

  self.status.values.each do |value|
    scope value.to_sym, -> { where(:status => value) }
  end

  def self.status_kinds
    status.values.map { |v| [v.to_s, v.text] }
  end

  def reindex_messages
    messages.delay.reindex
  end
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  type       :string
#  value      :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
