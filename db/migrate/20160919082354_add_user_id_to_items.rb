class AddUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :user_id, :integer
    remove_column :users,:item_id
  end
end
