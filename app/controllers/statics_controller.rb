class StaticsController < ApplicationController
  def home
    @recipes = Recipe.order('created_at desc').first(5)
  end

  def contact
  end

  def about
  end

  def privacy
  end
  
  def gear    
    @stoves = Link.where("link_type = ?", "stove")
    @pots = Link.where("link_type = ?", "pot|pan")
    @accessories = Link.where("link_type = ?", "stove+accessory")
    @spoons = Link.where("link_type = ?", "spoon|spatula")
    @plates = Link.where("link_type = ?", "plate|bowl")
    @sporks = Link.where("link_type = ?", "spork|spoon")
    @knives = Link.where("link_type = ?", "knife")
    @mugs = Link.where("link_type = ?", "cup|mug")
    @soaps = Link.where("link_type = ?", "soap|cooking")
  end
  
  def calories_calculator
  end
end
