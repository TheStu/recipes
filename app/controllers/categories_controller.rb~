class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to new_category_path
    else
      render action: "new"
    end
  end
  
  def index
    @category = params[:category].to_s.titleize
    @recipes = Recipe.joins(:categories).where('categories.name = ?', @category)
  end
end
