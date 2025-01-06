Rails.application.routes.draw do

  # 1. API Routes (these must come first!)
  namespace :api do
    resources :movies do
      member do
        # Favorite endpoints
        get 'favorite', to: 'movies#favorite_status'
        # Returns: { isFavorite: true/false }

        post 'favorite', to: 'movies#favorite'
        delete 'favorite', to: 'movies#unfavorite'
        # Both return: { success: true/false, message: "..." }

        # Watchlist endpoints
        get 'watchlist', to: 'movies#in_watchlist_status'
        # Returns: { isInWatchlist: true/false }

        post 'watchlist', to: 'movies#add_to_watchlist'
        delete 'watchlist', to: 'movies#remove_from_watchlist'
        # Both return: { success: true/false, message: "..." }

        # Rating endpoints
        get 'rate', to: 'movies#get_rate'
        post 'rate', to: 'movies#set_rate'
        delete 'rate', to: 'movies#unrate'
        # All return: { success: true/false, ... }

        get 'avg_rate', to: 'movies#avg_rate'
        # Returns: { avg_rate: number }

        # Media endpoints
        get 'posters', to: 'movies#get_posters'
        get 'backdrops', to: 'movies#get_backdrops'
        get 'videos', to: 'movies#get_videos'
        # All return: { success: true, urls: [...] } or { success: false, error: "..." }

        get 'popular_media', to: 'movies#popular_media'
        # Returns: { urls: [...] }

        get 'cast', to: 'movies#cast'  # Add this line
        get 'social', to: 'movies#social'
        get 'recommendations', to: 'movies#recommendations'

      end

      collection do
        get 'home_data'  # This will be /api/movies/home_data
      end
    end

    resources :keywords, only: [] do
      collection do
        get :search
      end
    end
  end

  # 2. Auth routes (if you're using Devise)
  devise_for :users

  # 3. Catch-all routes (these must be LAST!)
  root 'application#index'  # Handles the root URL '/'
  get '*path', to: 'application#index',  # Handles all other URLs
  constraints: lambda { |req| !req.path.include?('active_storage') }

end