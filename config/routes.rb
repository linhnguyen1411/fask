Rails.application.routes.draw do

  mount ActionCable.server => "/cable"

  devise_for :admins
  mount RailsAdmin::Engine => "/admin", as: :rails_admin
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "sessions/sessions"}
  root "static_pages#index"

  post "/upload_image", to: "images#upload_image"
  get "/download_file/:name", to: "images#access_file", as: :upload_access_file, name: /.*/

  resources :posts
  resources :suggest_tags, only: :index
  resources :tags, only: :index
  resources :topics
  resources :tag_users, only: :index
  resources :answers, only: [:create, :edit]
  resources :reactions, only: :create
  resources :comments, only: [:create, :update, :destroy]
  resources :activities, only: :index
  resources :users, only: [:index, :show]
  resources :follows, only: :update
  resources :clips, only: [:create, :destroy]
  resources :notifications, only: [:index, :update]
end
