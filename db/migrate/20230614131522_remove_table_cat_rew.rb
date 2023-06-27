class RemoveTableCatRew < ActiveRecord::Migration[6.1]
  def change
    drop_table :reward_categories do |t|
      t.integer "category_id"
      t.integer "reward_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
