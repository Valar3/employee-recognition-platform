class AddAddressDataToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :street, :string
    add_column :employees, :postcode, :string
    add_column :employees, :city, :string
  end
end
