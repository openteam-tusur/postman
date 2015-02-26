class AddPropertyReferencesToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :property, index: true
    add_foreign_key :messages, :properties
  end
end
