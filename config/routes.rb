Recipes::Application.routes.draw do

  resources :users, only: :show
  devise_for :users, :path_prefix => 'd'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'statics#home'
  match '/about', to: 'statics#about'
  match '/contact', to: 'statics#contact'
  match '/privacy', to: 'statics#privacy'

  resources :recipes
  resources :categories
  resources :reviews

  
end
