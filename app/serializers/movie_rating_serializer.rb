class MovieRatingSerializer
  def self.serialize(movie, user)
    rating = Rating.find_by(user: user, movie: movie)
    {
      movie_id: movie.id,
      is_rated: rating.present?,
      score: rating&.score,
      average_rating: movie.average_rating
    }
  end
end