class UserMovieInteractionSerializer < BaseSerializer
  attr_reader :user, :movie

  def initialize(movie, user)
    super(movie)
    @movie = movie
    @user = user
  end

  def self.serialize(movie, user)
    new(movie, user).serialize
  end

  def serialize
    return {} unless user

    {
      is_favorite: user.user_favorite_movies.exists?(movie_id: @movie.id),
      in_watchlist: user.watchlist&.movies&.exists?(id: @movie.id),
      user_rating: user.ratings.find_by(movie_id: @movie.id)&.score
    }
  end
end