class ChangeUserIdToStringForPermission < ActiveRecord::Migration
  def change
    change_column :permissions, :user_id, :string
  end
end
