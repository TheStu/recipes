Recipes::Application.routes.draw do

  root to: 'statics#home'
  match '/about', to: 'statics#about'
  match '/contact', to: 'statics#contact'
  match '/privacy', to: 'statics#privacy'

  devise_for :users, :path_prefix => 'd'
  resources :users, only: :show
  resources :recipes
  resources :categories

  
end
