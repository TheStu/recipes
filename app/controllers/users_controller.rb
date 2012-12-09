class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.where("user_id = ?", @user.id).order('created_at desc')
    @recipes = Recipe.where("user_id = ?", @user.id).order('created_at desc')
  end
end
