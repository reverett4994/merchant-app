class FixPriceColumn < ActiveRecord::Migration
  def change
    remove_column :items,:price
    add_column :items, :price, :decimal, precision: 8, scale: 2 
  end
end
