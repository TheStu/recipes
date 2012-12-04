class Recipe < ActiveRecord::Base
  attr_accessible :calories, :cooking_time, :equipment, :introduction, :picture, :preperation, :servings, 
  :title, :user, :weight, :category_attributes, :ingredient_attributes
  
  belongs_to :user
  has_many :category, :ingredient
  accepts_nested_attributes_for :category, :ingredient
end
