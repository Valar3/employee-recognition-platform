class AddOmniAuthToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :provider, :string
    add_column :employees, :uid, :string
  end
end
