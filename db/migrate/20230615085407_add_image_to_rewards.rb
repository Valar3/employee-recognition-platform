class AddImageToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :image, :string
  end
end
