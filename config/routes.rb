Seasonhunter::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root controller: :application, action: :index

  match "/auth/google_oauth2/callback" => "sessions#create", via: [:get, :post]
  get "/signout" => "sessions#destroy", :as => :signout

  resources :series, only: [:show] do
  	get :favorite
  	get :unfavorite
    post :create_comment
    post :update_rating

    get "/:season/:episode", controller: :episodes, action: :show, as: :episode

    post "/:season/:episode/comment", controller: :episodes, action: :create_comment, as: :episode_comment
    post "/:season/:episode/rating", controller: :episodes, action: :update_rating, as: :episode_rating

  end

  resources :users, only: [:index, :show]
  get "/search" => "search#index"

end
