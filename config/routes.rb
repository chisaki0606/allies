Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  get "users/:id/edit" => "users#edit"
  get "signup" => "users#new"
  post "signup" => "users#create"
  get "users/index" => "users#index"
  get "posts/new" => "posts#new"
  get 'message/:id' => 'messages#show', as: 'message'
  get "/users/last_message" => "posts/show_last_messages"

  resources :users, only: [:show, :update]
  resources :posts
  resources :messages, only: [:create]
  
  root to: 'posts#index'
end
