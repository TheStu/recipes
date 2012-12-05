class Recipe < ActiveRecord::Base

  mount_uploader :picture, RecipeUploader

  attr_accessible :calories, :cooking_time, :equipment, :introduction, :picture, :preperation, :servings, 
  :title, :user, :weight, :pots, :category_ids, :ingredients_attributes, :remove_picture
  
  belongs_to :user
  has_many :category_joins
  has_many :categories, :through => :category_joins, :dependent => :destroy
  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :category_joins
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  validates :pots, :inclusion => { :in => ['No Pot', '1 Pot', '2 Pots', '2+ Pots'],
    :message => "%{value} is not a valid number of pots" }
  validates :cooking_time, :numericality => {:only_integer => true, :message => "cooking time is not a number"}
  validates :servings, :numericality => {:only_integer => true, :message => "servings is not a number"}
  validates :cooking_time, :numericality => {:only_integer => true, :message => "ingredient weight is not a number"}
  validates :cooking_time, :numericality => {:only_integer => true, :message => "calories is not a number"}
end
