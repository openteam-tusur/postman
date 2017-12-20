class ContactMessage < ActiveRecord::Base
  extend Enumerize

  enumerize :status, :in => [:initialized, :sended, :received, :remotely_sended, :delivered, :failed], :default => :initialized, :predicates => true

  belongs_to :contact
  belongs_to :message

  after_commit :set_contact_status

  def good?
    %w(received delivered).include? status
  end

  private

  def set_contact_status
    if received? || delivered?
      contact.update_attributes :status => :good
    elsif failed?
      contact.update_attributes :status => :bad
    end
  end
end

# == Schema Information
#
# Table name: contact_messages
#
#  id               :integer          not null, primary key
#  contact_id       :integer
#  message_id       :integer
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  raw_email_status :text
#  remote_id        :string
#  uuid             :string
#
