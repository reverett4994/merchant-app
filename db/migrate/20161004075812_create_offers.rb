class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :item_id
      t.integer :user_id
      t.text :message

      t.timestamps null: false
    end
  end
end
