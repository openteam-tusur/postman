class ContactMessage < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:initialized, :sended, :received, :remotely_sended, :delivered, :failed], :default => :initialized, :predicates => true

  belongs_to :contact
  belongs_to :message

  after_commit :set_contact_status

  private

  def set_contact_status
    if received? || delivered?
      contact.update_attributes :status => :good
    elsif failed?
      contact.update_attributes :status => :bad
    end
  end
end
