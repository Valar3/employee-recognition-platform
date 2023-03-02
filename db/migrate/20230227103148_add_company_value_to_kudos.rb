class AddCompanyValueToKudos < ActiveRecord::Migration[6.1]
  def change
    add_reference :kudos, :company_value, foreign_key: true
  end
end
