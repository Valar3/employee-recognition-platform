class AddColumnNumberOfAvailableKudos < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :number_of_available_kudos, :integer, :default => 10
  end
end
