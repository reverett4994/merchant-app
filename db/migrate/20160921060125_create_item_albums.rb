class CreateItemAlbums < ActiveRecord::Migration
  def change
    create_table :item_albums do |t|
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
