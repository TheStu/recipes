class AddAverageStarsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :average_stars, :decimal
  end
end
