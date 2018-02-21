Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"

  devise_for :admins,
    controllers: {
      sessions: "admins/sessions"
    }
  mount RailsAdmin::Engine => "/admin", as: :rails_admin
  devise_for :users,
    controllers: {
      omniauth_callbacks: "omniauth_callbacks",
      registrations: "users/registrations",
      sessions: "sessions/sessions"
    }
  root "static_pages#index"
  # root to: "topics#show", id: Settings.topic.feedback_number
  post "/upload_image", to: "images#upload_image"
  get "/download_file/:name", to: "images#access_file", as: :upload_access_file, name: /.*/
  get "/change_languages/update"
  get "switch_user", to: "switch_user#set_current_user"

  resources :posts
  resources :suggest_tags, only: :index
  resources :tags, only: [:index, :show]
  resources :topics
  resources :tag_users, only: :index
  resources :answers, except: [:index, :new, :show]
  resources :reactions, only: [:create, :index]
  resources :comments, only: [:create, :update, :destroy]
  resources :activities, only: :index
  resources :users, only: [:index, :show, :update]
  resources :follows, only: :update
  resources :clips, only: [:create, :destroy]
  resources :notifications, only: [:index, :update]
  resources :user_settings, only: [:edit, :update]
  resources :a_versions
  resources :relationships, only: :index
  resources :categories
  namespace :dashboard do
    resources :posts
    resources :feedbacks, only: [:index, :update, :destroy]
    resources :managements
  end
  resources :contact_points
end
