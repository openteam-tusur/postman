class ContactMessage < ActiveRecord::Base
  belongs_to :contact
  belongs_to :message
end
