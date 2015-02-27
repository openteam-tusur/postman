class AddRawEmailStatusToContactMessage < ActiveRecord::Migration
  def change
    add_column :contact_messages, :raw_email_status, :text
  end
end
