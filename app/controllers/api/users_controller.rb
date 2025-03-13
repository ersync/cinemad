module Api
  class UsersController < Api::BaseController

    before_action :set_user, except: [:current]
    before_action :ensure_own_profile!, only: [:update, :avatar, :remove_avatar]
    skip_before_action :authenticate_user!, only: [:current]

    # GET /api/users/:username
    # Returns basic user information
    def show
      render_success(user: UserSerializer.serialize_basic(@user))
    end

    # PATCH/PUT /api/users/:username
    # Update user's profile information
    def update
      if @user.update(user_params)
        render_success(user: UserSerializer.serialize_basic(@user))
      else
        render_error(@user.errors.full_messages, :unprocessable_entity)
      end
    end

    # GET /api/users/:username/ratings
    # Returns all movies rated by the user
    def ratings
      @movies = @user.rated_movies.page(params[:page]).per(10)
      movies_with_interactions = MovieSerializers::List.serialize_collection(@movies).map.with_index do |movie_data, i|
        movie_data.merge(
          user_interactions: UserMovieInteractionSerializer.serialize(@movies[i], current_user)
        )
      end

      render_success(
        movies: movies_with_interactions,
        meta: {
          current_page: @movies.current_page,
          total_pages: @movies.total_pages,
          total_count: @movies.total_count,
          per_page: @movies.limit_value
        }
      )
    end

    # GET /api/users/:username/watchlist
    # Returns all movies in user's watchlist
    def watchlist
      @movies = @user.movies_to_watch
      .joins(:watchlist_movies)
      .where(watchlist_movies: { watchlist_id: @user.watchlist.id })
      .order('watchlist_movies.created_at DESC')
      .page(params[:page]).per(10)
      movies_with_interactions = MovieSerializers::List.serialize_collection(@movies).map.with_index do |movie_data, i|
        movie_data.merge(
          user_interactions: UserMovieInteractionSerializer.serialize(@movies[i], current_user)
        )
      end

      render_success(
        movies: movies_with_interactions,
        meta: {
          current_page: @movies.current_page,
          total_pages: @movies.total_pages,
          total_count: @movies.total_count,
          per_page: @movies.limit_value
        }
      )
    end

    # GET /api/users/:username/favorites
    # Returns all movies favorited by the user
    def favorites
      @movies = @user.favorite_movies
      .joins(:user_favorite_movies)
      .where(user_favorite_movies: { user_id: @user.id })
      .order('user_favorite_movies.created_at DESC')
      .page(params[:page]).per(10)
      movies_with_interactions = MovieSerializers::List.serialize_collection(@movies).map.with_index do |movie_data, i|
        movie_data.merge(
          user_interactions: UserMovieInteractionSerializer.serialize(@movies[i], current_user)
        )
      end

      render_success(
        movies: movies_with_interactions,
        meta: {
          current_page: @movies.current_page,
          total_pages: @movies.total_pages,
          total_count: @movies.total_count,
          per_page: @movies.limit_value
        }
      )
    end

    # POST /api/users/:username/avatar
    # Upload user's avatar image
    def avatar
      if params[:avatar].nil?
        render_error(['No avatar provided'], :unprocessable_entity)
        return
      end

      if @user.avatar.attach(params[:avatar])
        render_success(user: UserSerializer.serialize_basic(@user))
      else
        render_error(@user.errors.full_messages.presence || ['Upload failed'], :unprocessable_entity)
      end
    end

    # DELETE /api/users/:username/avatar
    # Remove user's avatar image
    def remove_avatar
      @user.avatar.purge if @user.avatar.attached?
      render_success(user: UserSerializer.serialize_basic(@user))
    end

    # GET /api/users/current
    # Returns current logged-in user's information
    def current
      if current_user
        render_success(user: UserSerializer.serialize_basic(current_user))
      else
        render_error('Not authenticated', :unauthorized)
      end
    end

    private

    def set_user
      @user = User.find_by!(username: params[:id])
    end

    def ensure_own_profile!
      unless @user == current_user
        render_error(['You can only modify your own profile'], :forbidden)
      end
    end

    def user_params
      params.require(:user).permit(:username, :email)
    end
  end
end