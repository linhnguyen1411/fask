Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "static_pages#index"

  resources :posts, only: [:index, :new, :create]
  resources :tags, only: :index
  resources :topics
  resources :tag_users, only: :index
end
