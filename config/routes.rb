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

    get "/:season/:episode", controller: :episodes, action: :show, as: :episode
    post "/:season/:episode/comment", controller: :episodes, action: :create_comment, as: :episode_comment
  end

  resources :users, only: [:index, :show]
  get "/search" => "search#index"

end
