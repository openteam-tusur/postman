class AddUuiDtoContact < ActiveRecord::Migration
  def change
    add_column :contact_messages, :uuid, :string
  end
end
