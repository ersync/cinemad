Rails.application.routes.draw do
  namespace :api do
    resources :movies do
      collection do
        get 'discovery'
        get 'home_page'
        get 'search'
        get 'search_keywords'
      end

      member do
        resource :favorite, only: [:show, :create, :destroy], controller: 'movie_favorites'
        resource :watchlist, only: [:show, :create, :destroy], controller: 'movie_watchlist'
        resource :rating, only: [:show, :create, :destroy], controller: 'movie_ratings'

        resources :media, only: [], controller: 'movie_media' do
          collection do
            get :posters
            get :backdrops
            get :videos
          end
        end

        get 'average_rating'
        get 'cast'
        get :reviews 
        get 'review_section'
        get 'recommendations'
      end
    end

    resources :users, only: [:show, :update] do
      member do
        get 'ratings'
        get 'watchlist'
        get 'favorites'

        get 'stats'

        post 'avatar'
        delete 'avatar', to: 'users#remove_avatar'
        post 'background'
        delete 'background'

        patch 'social'
      end

      collection do
        get :current, to: "users#current"
      end
    end

    resources :keywords, only: [] do
      collection do
        get :search
      end
    end
    
  end

  get '/users/sign_in', to: redirect('/login')
  get '/users/sign_up', to: redirect('/register')

  devise_for :users, controllers: {
    sessions: 'api/sessions',
    omniauth_callbacks: 'api/omniauth_callbacks'
  }, defaults: { format: :json }

  # Catch-all routes
  root 'application#index'
  get '*path', to: 'application#index',
    constraints: lambda { |req| !req.path.include?('active_storage') }
end