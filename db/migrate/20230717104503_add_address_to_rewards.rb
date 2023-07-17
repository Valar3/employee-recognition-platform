class AddAddressToRewards < ActiveRecord::Migration[7.0]
  def change
    add_column :rewards, :street, :string
    add_column :rewards, :postcode, :string
    add_column :rewards, :city, :string
  end
end
