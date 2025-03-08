class MovieFavoriteSerializer
  def self.serialize(movie, user)
    {
      movie_id: movie.id,
      is_favorite: user&.favorite_movies&.exists?(id: movie.id) || false
    }
  end
end