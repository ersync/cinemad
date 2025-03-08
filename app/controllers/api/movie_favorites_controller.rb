module Api
  class MovieFavoritesController < BaseController
    before_action :set_movie

    def show
      render_success(
        favorite: MovieFavoriteSerializer.serialize(@movie, current_user)
      )
    end

    def create
      result = favorite_service.add_to_favorites

      handle_service_result(
        result,
        success_message: Favorite::SUCCESS[:added],
        error_status: :unprocessable_entity
      )
    end

    def destroy
      result = favorite_service.remove_from_favorites

      handle_service_result(
        result,
        success_message: Favorite::SUCCESS[:removed],
        error_status: :unprocessable_entity
      )
    end

    private

    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def favorite_service
      @favorite_service ||= MovieServices::FavoriteService.new(current_user, @movie)
    end

    def handle_service_result(result, success_message:, error_status:)
      if result.success?
        render_success(message: success_message)
      else
        render_error(result.error, error_status)
      end
    end
  end
end