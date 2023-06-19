class RemoveTableCatRew < ActiveRecord::Migration[6.1]
  def change
    drop_table :reward_categories
  end
end
