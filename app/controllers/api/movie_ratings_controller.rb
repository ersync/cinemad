module Api
  class MovieRatingsController < BaseController
    include ApiMessages
    before_action :set_movie

    def show
      render_success(
        rating: MovieRatingSerializer.serialize(@movie, current_user)
      )
    end

    def create
      result = rating_service(params[:score]).rate

      if result.success?
        render_success(
          message: Rating::SUCCESS[:created],
          rating: MovieRatingSerializer.serialize(@movie, current_user)
        )
      else
        render_error(result.error, :unprocessable_entity)
      end
    end

    def destroy
      result = rating_service.unrate

      if result.success?
        render_success(
          message: Rating::SUCCESS[:removed],
          rating: { average_rating: @movie.average_rating }
        )
      else
        render_error(result.error, :unprocessable_entity)
      end
    end

    private

    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def rating_service(score = nil)
      @rating_service ||= MovieServices::RatingService.new(current_user, @movie, score)
    end
  end
end