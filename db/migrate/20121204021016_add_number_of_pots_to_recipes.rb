class AddNumberOfPotsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :pots, :string
    add_index :recipes, :pots
  end
  
end
