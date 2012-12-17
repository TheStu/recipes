require 'test_helper'

class MealPlansControllerTest < ActionController::TestCase
  setup do
    @meal_plan = meal_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meal_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meal_plan" do
    assert_difference('MealPlan.count') do
      post :create, meal_plan: { name: @meal_plan.name, total_calories: @meal_plan.total_calories, total_days: @meal_plan.total_days, total_people: @meal_plan.total_people, user_id: @meal_plan.user_id }
    end

    assert_redirected_to meal_plan_path(assigns(:meal_plan))
  end

  test "should show meal_plan" do
    get :show, id: @meal_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meal_plan
    assert_response :success
  end

  test "should update meal_plan" do
    put :update, id: @meal_plan, meal_plan: { name: @meal_plan.name, total_calories: @meal_plan.total_calories, total_days: @meal_plan.total_days, total_people: @meal_plan.total_people, user_id: @meal_plan.user_id }
    assert_redirected_to meal_plan_path(assigns(:meal_plan))
  end

  test "should destroy meal_plan" do
    assert_difference('MealPlan.count', -1) do
      delete :destroy, id: @meal_plan
    end

    assert_redirected_to meal_plans_path
  end
end
