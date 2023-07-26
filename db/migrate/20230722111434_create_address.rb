class CreateAddress < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :postcode
      t.string :city
      t.references :employee, foreign_key: { to_table: :employees }
      t.datetime :last_used
      t.timestamps
    end
  end
end
