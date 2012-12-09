class ChangeAverageStarsDefault < ActiveRecord::Migration
  def change
    change_column :recipes, :average_stars, :decimal, :default => 0
    change_column :recipes, :weight, :integer, :default => 0
    change_column :recipes, :calories, :integer, :default => 0
  end
end
