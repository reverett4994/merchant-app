class AddZioForItems < ActiveRecord::Migration
  def change
    add_column :items, :zip, :string

  end
end
