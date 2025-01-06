module Rateable
  extend ActiveSupport::Concern

  def avg_rate
    render json: { avg_rate: @movie.average_rating }
  end

  def get_rate
    rating = Rating.find_by(user: current_user, movie: @movie)
    result = if rating
               { success: true, isRated: true, score: rating.score }
             else
               { success: true, isRated: false }
             end

    render_result(result)
  end

  def set_rate
    rating = Rating.find_or_initialize_by(user: current_user, movie: @movie)
    rating.score = params[:rate]

    result = if rating.save
               { success: true, isRated: true, message: "Rating updated successfully" }
             else
               { success: false, error: "Failed to update rating" }
             end

    render_result(result)
  end

  def unrate
    rating = Rating.find_by(user: current_user, movie: @movie)

    result = if rating&.destroy
               { success: true, isRated: false, message: 'Movie unrated successfully' }
             else
               { success: false, isRated: true, error: rating ? 'Failed to unrate movie' : 'The movie was not rated' }
             end

    render_result(result)
  end

  private

  def render_result(result)
    render json: result, status: result[:success] ? :ok : :unprocessable_entity
  end
end