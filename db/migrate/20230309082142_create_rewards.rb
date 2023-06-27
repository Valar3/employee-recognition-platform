class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string 'title', null: false
      t.text 'description',null: false
      t.decimal 'price', null: false, precision: 8, scale: 2
      t.timestamps
    end
  end
end
