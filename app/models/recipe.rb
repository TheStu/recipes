class Recipe < ActiveRecord::Base

  mount_uploader :picture, RecipeUploader

  attr_accessible :calories, :cooking_time, :equipment, :introduction, :picture, :preperation, :servings, 
  :title, :user, :weight, :pots, :category_ids, :ingredients_attributes, :remove_picture, :average_stars
  
  belongs_to :user
  has_many :category_joins
  has_many :categories, :through => :category_joins, :dependent => :destroy
  has_many :ingredients, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  accepts_nested_attributes_for :category_joins
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  validates :pots, :inclusion => { :in => ['0', '1', '2', '2+'],
    :message => "%{value} is not a valid number of pots" }
  validates :cooking_time, :numericality => {:only_integer => true, :message => "cooking time is not a number"}
  validates :servings, :numericality => {:only_integer => true, :message => "servings is not a number"}
  validates :cooking_time, :numericality => {:only_integer => true, :message => "ingredient weight is not a number"}
  validates :cooking_time, :numericality => {:only_integer => true, :message => "calories is not a number"}
end
