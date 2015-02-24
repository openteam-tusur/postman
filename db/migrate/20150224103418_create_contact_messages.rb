class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.references :contact, index: true
      t.references :message, index: true
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :contact_messages, :contacts
    add_foreign_key :contact_messages, :messages
  end
end
