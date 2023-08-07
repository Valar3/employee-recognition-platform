class AddOptionalToAvailableRewards < ActiveRecord::Migration[7.0]
  def change
    change_column :rewards, :available_rewards, :integer, optional: :true
  end
end
