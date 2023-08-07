class ChangeColumnInRewards < ActiveRecord::Migration[7.0]
  def change
    add_column :rewards, :delivery_method, :integer, default: '0'
  end
end
