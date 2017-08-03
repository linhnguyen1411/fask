Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "static_pages#index"

  resources :posts, only: [:new, :create]
  resources :tags, only: :index
end
