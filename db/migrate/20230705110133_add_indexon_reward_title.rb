class AddIndexonRewardTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :rewards, :title, unique: :true
  end
end
