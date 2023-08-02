class AddAvailableRewardsToRewards < ActiveRecord::Migration[7.0]
  def change
    add_column :rewards, :available_rewards, :integer
  end
end
