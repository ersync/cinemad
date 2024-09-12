Rails.application.routes.draw do

  devise_for :users

  resources :movies do
    member do
      post 'rate', to: 'movies#set_rate'
      delete 'rate', to: 'movies#unrate'
      get 'rate', to: 'movies#get_rate'
      get 'avg_rate', to: 'movies#avg_rate'

      post 'favorite', to: 'movies#favorite'
      get 'favorite', to: 'movies#favorite_status'
      delete 'favorite', to: 'movies#unfavorite'

      post 'watchlist', to: 'movies#add_to_watchlist'
      get 'watchlist', to: 'movies#in_watchlist_status'
      delete 'watchlist', to: 'movies#remove_from_watchlist'

      get 'posters', to: 'movies#get_posters'
      get 'backdrops', to: 'movies#get_backdrops'
      get 'videos', to: 'movies#get_videos'
      get 'popular_media', to: 'movies#popular_media'
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
  root "movies#home"

  resources :keywords, only: [] do
    collection do
      get :search
    end
  end
end
