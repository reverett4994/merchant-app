class AddAllTheThingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :zip, :integer
    add_column :users, :full_name, :string
    add_column :users, :item_id, :integer
  end
end
