class AddImageToItems < ActiveRecord::Migration
  def change

    def up
      add_attachment :items, :image
    end

    def down
      remove_attachment :items, :image
    end
  end
end
