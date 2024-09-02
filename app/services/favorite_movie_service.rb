class FavoriteMovieService
  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def favorite!
    return { success: false, error: 'Movie is already a favorite' } if already_favorite?

    @user.favorite_movies << @movie
    if @user.save
      { success: true, isFavorite: true }
    else
      { success: false, error: 'Failed to add movie to favorites' }
    end
  end

  def unfavorite!
    movie_in_favorites = @user.user_favorite_movies.find_by(movie_id: @movie.id)
    if movie_in_favorites&.destroy
      { success: true, message: 'Movie removed from favorites', isFavorite: false }
    else
      { success: false, error: movie_in_favorites ? 'Failed to remove movie from favorites' : 'The movie was not found in favorites' }
    end
  end

  def already_favorite?
    @user.favorite_movies.exists?(id: @movie.id)
  end

end