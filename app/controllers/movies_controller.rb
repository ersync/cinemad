class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_movie, only: [:favorite, :favorite_status, :unfavorite, :in_watchlist_status, :add_to_watchlist, :remove_from_watchlist]

  def show
    @movie = Movie.includes(:keywords).find(params[:id])
    @featured_review = @movie.reviews.first
    @crew = @movie.people
                  .includes(movie_people: :role)
                  .where.not(movie_people: { role_id: 1 })
    @is_favorited = current_user&.favorite_movies&.exists?(@movie.id)
  end

  def index

  end

  def home
    @random_movies = Movie.random_movies(12)
  end

  def new
  end

  def edit
  end

  def favorite_status
    is_favorite = current_user.favorite_movies.exists?(@movie.id)
    render json: { isFavorite: is_favorite }
  end

  def favorite
    movie_in_favorites = current_user.user_favorite_movies.find_by(movie_id: @movie.id)
    if movie_in_favorites
      render json: { error: 'Movie is already a favorite' }, status: :conflict
      return
    end
    current_user.favorite_movies << @movie
    if current_user.save
      render json: { isFavorite: true }, status: :ok
    else
      render json: { error: 'Failed to add movie to favorites' }, status: :unprocessable_entity
    end
  end

  def unfavorite
    movie_in_favorites = current_user.user_favorite_movies.find_by(movie_id: @movie.id)
    if movie_in_favorites&.destroy
      render json: { message: 'Movie removed from favorites', isFavorite: false }, status: :ok
    else
      render json: { error: movie_in_favorites ? 'Failed to remove movie from favorites' : 'The movie was not found in favorites' }, status: :unprocessable_entity
    end
  end

  def in_watchlist_status
    isInWatchlist = current_user.watchlist&.movies&.exists?(@movie.id)
    render json: { isInWatchlist: isInWatchlist }
  end

  def add_to_watchlist
    movie_in_watchlist = current_user.watchlist&.watchlist_movies&.find_by(movie_id: @movie.id)
    if movie_in_watchlist
      render json: { error: 'Movie is already in the watchlist' }, status: :ok
      return
    end
    watchlist = current_user.watchlist || current_user.build_watchlist
    watchlist.movies << @movie
    if watchlist.save
      render json: { isInWatchlist: true }, status: :ok
    else
      render json: { error: 'Failed to add movie to watchlist' }, status: :unprocessable_entity
    end
  end

  def remove_from_watchlist
    movie_in_watchlist = current_user.watchlist&.watchlist_movies&.find_by(movie_id: @movie.id)

    if movie_in_watchlist&.destroy
      render json: { message: 'Movie removed from watchlist successfully', isInWatchlist: false }, status: :ok
    else
      render json: { error: movie_in_watchlist ? 'Failed to remove movie from watchlist' : 'The movie was not found in the watchlist' }, status: :unprocessable_entity
    end
  end

  private

  def get_movie
    @movie = Movie.find(params[:id])
  end
end
