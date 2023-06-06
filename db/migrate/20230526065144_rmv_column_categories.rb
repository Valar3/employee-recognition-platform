class RmvColumnCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :category
  end
end
