module Favoriteable
  extend ActiveSupport::Concern

  def favorite_status
    render json: { isFavorite: favorite_service.already_favorite? }
  end

  def favorite
    result = favorite_service.favorite!
    render json: result, status: result[:success] ? :ok : :unprocessable_entity
  end

  def unfavorite
    result = favorite_service.unfavorite!
    render json: result, status: result[:success] ? :ok : :unprocessable_entity
  end

  private

  def favorite_service
    @favorite_service ||= FavoriteMovieService.new(current_user, @movie)
  end
end
