module Watchlistable
  extend ActiveSupport::Concern

  def in_watchlist_status
    is_in_watchlist = current_user.watchlist&.movies&.exists?(@movie.id)
    render json: { isInWatchlist: is_in_watchlist }
  end

  def add_to_watchlist
    if current_user.watchlist&.movies&.exists?(@movie.id)
      result = { success: false, error: 'Movie is already in the watchlist' }
    else
      watchlist = current_user.watchlist || current_user.build_watchlist
      watchlist.movies << @movie

      result = if watchlist.save
                 { success: true, isInWatchlist: true }
               else
                 { success: false, error: 'Failed to add movie to watchlist' }
               end
    end

    render_result(result)
  end

  def remove_from_watchlist
    watchlist_movie = current_user.watchlist&.watchlist_movies&.find_by(movie_id: @movie.id)

    result = if watchlist_movie&.destroy
               { success: true, message: 'Movie removed from watchlist successfully', isInWatchlist: false }
             else
               { success: false, error: watchlist_movie ? 'Failed to remove movie from watchlist' : 'The movie was not found in the watchlist' }
             end

    render_result(result)
  end

  private

  def render_result(result)
    render json: result, status: result[:success] ? :ok : :unprocessable_entity
  end
end