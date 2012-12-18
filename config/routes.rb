Recipes::Application.routes.draw do

  resources :users, only: :show
  devise_for :users, :path_prefix => 'd'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'statics#home'
  match '/about', to: 'statics#about'
  match '/contact', to: 'statics#contact'
  match '/privacy', to: 'statics#privacy'
  match '/camping-cooking-gear', to: 'statics#gear', as: 'cooking_gear'
  match '/calorie-calculator', to: 'statics#calories_calculator', as: 'calculator'
  
  match '/category/:category', to: 'categories#index', as: 'category_index'
  
  get "/calorie-calculator-results" => "statics#results", as: 'results'

  resources :recipes
  resources :categories
  resources :reviews
  resources :meal_plans, :path => 'meal-plan'

  
end
