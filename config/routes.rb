Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  get "users/:id/edit" => "users#edit"
  get "signup" => "users#new"
  post "signup" => "users#create"
  get "users/index" => "users#index"
  get "posts/new" => "posts#new"

  resources :users, only: [:show, :update]
  resources :posts
  root to: 'posts#index'
end
