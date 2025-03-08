class   MovieWatchlistSerializer
  def self.serialize(movie, user)
    {
      movie_id: movie.id,
      in_watchlist: user&.watchlist&.movies&.exists?(movie.id) || false
    }
  end
end