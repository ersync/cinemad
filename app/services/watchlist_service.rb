class WatchlistService
  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def watchlist!
    return { error: 'Movie is already in the watchlist' } if in_watchlist?

    watchlist = @user.watchlist || @user.build_watchlist
    watchlist.movies << @movie
    if watchlist.save
      { success: true, isInWatchlist: true }
    else
      { success: false, error: 'Failed to add movie to watchlist' }
    end
  end

  def unwatchlist!
    watchlist_movie = @user.watchlist&.watchlist_movies&.find_by(movie_id: @movie.id)
    if watchlist_movie&.destroy
      { success: true, message: 'Movie removed from watchlist successfully', isInWatchlist: false }
    else
      { success: false, error: watchlist_movie ? 'Failed to remove movie from watchlist' : 'The movie was not found in the watchlist' }
    end
  end

  def in_watchlist?
    @user.watchlist&.movies&.exists?(@movie.id)
  end

end