class AddUpdateIndexToOrder < ActiveRecord::Migration[6.1]
  def change
    remove_index :orders, [:business_unit_slot_id, :order_date], unique: true
    add_index :orders, [:business_unit_slot_id, :order_date], unique: true, where: 'finished IS true'
  end
end
