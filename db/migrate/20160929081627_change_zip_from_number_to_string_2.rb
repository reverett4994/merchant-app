class ChangeZipFromNumberToString2 < ActiveRecord::Migration
  def change
    remove_column :users,:zip
    add_column :users, :zip, :string
  end
end
