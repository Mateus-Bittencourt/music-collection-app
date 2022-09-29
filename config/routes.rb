Rails.application.routes.draw do
  devise_for :users
  root to: "artists#index"

  resources :albums, except: :show
  resources :artists, only: :index do
    resources :albums, only: :index
  end
end
