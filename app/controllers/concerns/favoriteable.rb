module Favoriteable
  extend ActiveSupport::Concern

  def favorite_status
    is_favorite = current_user.favorite_movies.exists?(id: @movie.id)
    render json: { isFavorite: is_favorite }
  end

  def favorite
    if current_user.favorite_movies.exists?(id: @movie.id)
      render json: { success: false, error: 'Movie is already a favorite' },
        status: :unprocessable_entity
      return
    end

    current_user.favorite_movies << @movie
    if current_user.save
      render json: { success: true, isFavorite: true }
    else
      render json: { success: false, error: 'Failed to add movie to favorites' },
        status: :unprocessable_entity
    end
  end

  def unfavorite
    movie_in_favorites = current_user.user_favorite_movies.find_by(movie_id: @movie.id)

    if movie_in_favorites&.destroy
      render json: {
        success: true,
        message: 'Movie removed from favorites',
        isFavorite: false
      }
    else
      render json: {
        success: false,
        error: movie_in_favorites ? 'Failed to remove movie from favorites' : 'The movie was not found in favorites'
      }, status: :unprocessable_entity
    end
  end
end