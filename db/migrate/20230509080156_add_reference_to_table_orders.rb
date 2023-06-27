class AddReferenceToTableOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :employee, foreign_key: true
    add_reference :orders, :reward, foreign_key: true
  end
end
