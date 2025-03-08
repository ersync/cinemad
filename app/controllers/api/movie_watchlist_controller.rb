module Api
  class MovieWatchlistController < BaseController
    before_action :set_movie

    def show
      render_success(
        watchlist: MovieWatchlistSerializer.serialize(@movie, current_user)
      )
    end

    def create
      result = watchlist_service.add_to_watchlist

      handle_service_result(
        result,
        success_message: Watchlist::SUCCESS[:added],
        error_status: :unprocessable_entity
      )
    end

    def destroy
      result = watchlist_service.remove_from_watchlist

      handle_service_result(
        result,
        success_message: Watchlist::SUCCESS[:removed],
        error_status: :unprocessable_entity
      )
    end

    private

    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def watchlist_service
      @watchlist_service ||= MovieServices::WatchlistService.new(current_user, @movie)
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