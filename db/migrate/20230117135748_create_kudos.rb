class CreateKudos < ActiveRecord::Migration[6.1]
  def change
    create_table :kudos do |t|
      t.string :Title, null: false
      t.text :Content, null: false
      t.integer :giver_id, null: false
      t.integer :receiver_id, null: false
      t.timestamps
    end
  end
end
