class AddColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :price, :decimal, null: false, precision: 8, scale: 2
  end
end
