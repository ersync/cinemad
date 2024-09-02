module Rateable
  extend ActiveSupport::Concern

  def avg_rate
    render json: { avg_rate: @movie.average_rating }
  end

  def get_rate
    result = rating_service.get_rate
    render_result(result)
  end

  def set_rate
    result = rating_service.set_rate(params[:rate])
    render_result(result)
  end

  def unrate
    result = rating_service.unrate
    render_result(result)
  end

  def render_result(result)
    render json: result, status: result[:success] ? :ok : :unprocessable_entity
  end

  def rating_service
    @rating_service ||= RatingService.new(current_user, @movie)
  end
end