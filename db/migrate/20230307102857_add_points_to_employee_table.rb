class AddPointsToEmployeeTable < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :number_of_earned_points, :float, default: 0
  end
end
