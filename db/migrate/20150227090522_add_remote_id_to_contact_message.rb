class AddRemoteIdToContactMessage < ActiveRecord::Migration
  def change
    add_column :contact_messages, :remote_id, :string
  end
end
