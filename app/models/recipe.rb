class Recipe < ActiveRecord::Base
  attr_accessible :calories, :cooking_time, :equipment, :introduction, :picture, :preperation, :servings, 
  :title, :user, :weight, :pots, :category_attributes, :ingredient_attributes
  
  belongs_to :user
  has_many :category_joins
  has_many :categories, :through => :category_joins, :dependent => :destroy
  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :ingredients
end
