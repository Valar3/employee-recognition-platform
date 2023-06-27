class AddCompanyValueToKudos < ActiveRecord::Migration[6.1]
  def change
    add_column :kudos, :company_value_id, :integer, foreign_key: true
  end
end
