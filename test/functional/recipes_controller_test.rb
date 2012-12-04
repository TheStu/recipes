require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, recipe: { calories: @recipe.calories, cooking_time: @recipe.cooking_time, equipment: @recipe.equipment, introduction: @recipe.introduction, picture: @recipe.picture, preperation: @recipe.preperation, servings: @recipe.servings, title: @recipe.title, user: @recipe.user, weight: @recipe.weight }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, id: @recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe
    assert_response :success
  end

  test "should update recipe" do
    put :update, id: @recipe, recipe: { calories: @recipe.calories, cooking_time: @recipe.cooking_time, equipment: @recipe.equipment, introduction: @recipe.introduction, picture: @recipe.picture, preperation: @recipe.preperation, servings: @recipe.servings, title: @recipe.title, user: @recipe.user, weight: @recipe.weight }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to recipes_path
  end
end
