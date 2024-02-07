Rails.application.routes.draw do

  devise_for :users

  resources :movies do
    member do
      get 'posters_ajax', to: 'movies#posters_ajax'
    end
  end

  get '/u/:username', to: 'users#show', as: :user_profile

  resources :users, path: "u", only: [:show, :edit] do
    get 'ratings', on: :member
    get 'watchlist', on: :member
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "movies#index"
end
