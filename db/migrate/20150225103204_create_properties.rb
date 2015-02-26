class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.string :type
      t.text :url
      t.text :footer

      t.timestamps null: false
    end
  end
end
