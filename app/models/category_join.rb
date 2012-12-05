class CategoryJoin < ActiveRecord::Base
  attr_accessible :category_id, :recipe_id
  belongs_to :recipe
  belongs_to :category
end
