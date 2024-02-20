class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_movie, except: [:index, :home]

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
      render json: { success: false, error: 'Movie is already a favorite' }, status: :conflict
      return
    end
    current_user.favorite_movies << @movie
    if current_user.save
      render json: { success: true, isFavorite: true }, status: :ok
    else
      render json: { success: false, error: 'Failed to add movie to favorites' }, status: :unprocessable_entity
    end
  end

  def unfavorite
    movie_in_favorites = current_user.user_favorite_movies.find_by(movie_id: @movie.id)
    if movie_in_favorites&.destroy
      render json: { success: true, message: 'Movie removed from favorites', isFavorite: false }, status: :ok
    else
      render json: { success: false, error: movie_in_favorites ? 'Failed to remove movie from favorites' : 'The movie was not found in favorites' }, status: :unprocessable_entity
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
      render json: { success: true, isInWatchlist: true }, status: :ok
    else
      render json: { success: false, error: 'Failed to add movie to watchlist' }, status: :unprocessable_entity
    end
  end

  def remove_from_watchlist
    movie_in_watchlist = current_user.watchlist&.watchlist_movies&.find_by(movie_id: @movie.id)

    if movie_in_watchlist&.destroy
      render json: { success: true, message: 'Movie removed from watchlist successfully', isInWatchlist: false }, status: :ok
    else
      render json: { success: false, error: movie_in_watchlist ? 'Failed to remove movie from watchlist' : 'The movie was not found in the watchlist' }, status: :unprocessable_entity
    end
  end

  def avg_rate
    avg_rate = @movie.ratings.average(:score).to_i || 0
    render json: { avg_rate: avg_rate }
  end

  def rate
    rate = params[:rate]
    user_id = current_user.id
    movie_id = params[:id]

    rating = Rating.find_or_initialize_by(user_id: user_id, movie_id: movie_id)
    rating.score = rate

    if rating.save
      render json: { success: true, isRated: true, message: "Rating updated successfully" }
    else
      render json: { success: false, error: "Failed to update rating" }, status: :unprocessable_entity
    end
  end

  def unrate
    user_rating = current_user.ratings.find_by(movie_id: @movie.id)
    if user_rating&.destroy
      render json: { success: true, message: 'Movie unrated successfully', isRated: false }, status: :ok
    else
      render json: { success: false, error: user_rating ? 'Failed to unrate movie' : 'The movie was not rated' }, status: :unprocessable_entity
    end
  end

  def rating_status
    user_rating = current_user.ratings&.find_by(movie_id: @movie.id)
    if user_rating.present?
      render json: { success: true, isRated: true, rate: user_rating.score }
    else
      render json: { success: false, isRated: false }
    end
  rescue => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def get_posters
    render_media_urls_json(@movie.posters, 'No posters found for the movie')
  end

  def get_backdrops
    render_media_urls_json(@movie.backdrops, 'No backdrops found for the movie')
  end

  def get_videos
    render_media_urls_json(@movie.videos.order(:id), 'No videos found for the movie') { |video| { url: video.url, isVideo: true } }
  end

  def popular_media
    random_videos = @movie.videos.order(Arel.sql('RANDOM()')).limit(2).map { |video| { url: video.url, isVideo: true } }

    random_backdrops = @movie.backdrops.order(Arel.sql('RANDOM()')).limit(2).map { |backdrop| { url: rails_blob_url(backdrop), isVideo: false } }

    urls = random_videos + random_backdrops

    render json: { urls: urls }, status: :ok

  end

  private

  def get_movie
    @movie = Movie.find(params[:id])
  end

  def render_media_urls_json(media, error_message)
    if media.present?
      urls = block_given? ? media.map { |item| yield(item) } : media.map { |item| { url: rails_blob_url(item), isVideo: false } }
      render json: { success: true, urls: urls }, status: :ok
    else
      render_json_error(error_message)
    end
  end

  def render_boolean_json(key, value)
    render json: { key => value }
  end

  def render_json_error(message)
    render json: { success: false, error: message }, status: :unprocessable_entity
  end
end
