class AddNameAndSurnameToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :name, :string, :null => false
    add_column :employees, :surname, :string, :null => false
   end
end
