class AddCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :category, :string
  end
end
