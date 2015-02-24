class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :type
      t.string :value
      t.string :status

      t.timestamps null: false
    end
  end
end
