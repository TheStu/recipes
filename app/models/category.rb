class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :category_joins
  has_many :recipes, :through => :category_joins
end
