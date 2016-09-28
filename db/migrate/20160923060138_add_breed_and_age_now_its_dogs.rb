class AddBreedAndAgeNowItsDogs < ActiveRecord::Migration
  def change
    add_column :items, :breed, :string
    add_column :items, :age, :integer

  end
end
