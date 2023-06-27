class CreateRewardCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :reward_categories do |t|
      t.integer :category_id
      t.integer :reward_id
      t.timestamps
    end
  end
end
