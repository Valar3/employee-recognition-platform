class RmvColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :category, :string
  end
end
