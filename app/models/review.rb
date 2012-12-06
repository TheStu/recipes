class Review < ActiveRecord::Base
  attr_accessible :content, :stars, :recipe_id
  
  belongs_to :user
  belongs_to :recipe
end
