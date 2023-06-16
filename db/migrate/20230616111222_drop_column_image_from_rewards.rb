class DropColumnImageFromRewards < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :image
  end
end
