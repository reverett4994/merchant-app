class AddAttachmentImageToItemAlbums < ActiveRecord::Migration
  def self.up
    change_table :item_albums do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :item_albums, :image
  end
end
