class Category < ActiveRecord::Base
  attr_accessible :name, :recipe_id
  
  belongs_to :recipe
end
