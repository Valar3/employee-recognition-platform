class AddIndexToCompanyValue < ActiveRecord::Migration[6.1]
  def change
    add_index :company_values, :title, :unique => true
    #Ex:- add_index("admin_users", "username")
  end
end
