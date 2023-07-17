class AddAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :street, :string
    add_column :orders, :postcode, :string
    add_column :orders, :city, :string
  end
end
