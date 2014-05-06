Seasonhunter::Application.routes.draw do
  root controller: :application, action: :index

  match "/auth/google_oauth2/callback" => "sessions#create", via: [:get, :post]
  get "/signout" => "sessions#destroy", :as => :signout

  resources :series, only: [:show]
  resources :users, only: [:index, :show]

end
