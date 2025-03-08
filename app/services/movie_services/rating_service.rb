module MovieServices
  class RatingService
    include Api::ApiMessages

    def initialize(user, movie, score = nil)
      @user = user
      @movie = movie
      @score = score
    end

    def rate
      return ServiceResult.error(Rating::ERROR[:invalid]) if @score && !@score.to_i.between?(1, 100)

      # Use :: prefix to reference the global Rating model
      rating = ::Rating.find_or_initialize_by(user: @user, movie: @movie)
      rating.score = @score

      if rating.save
        ServiceResult.success
      else
        ServiceResult.error(Rating::ERROR[:create_failed])
      end
    end

    def unrate
      # Use :: prefix to reference the global Rating model
      rating = ::Rating.find_by(user: @user, movie: @movie)
      return ServiceResult.error(Rating::ERROR[:not_found]) unless rating

      rating.destroy ? ServiceResult.success : ServiceResult.error(Rating::ERROR[:remove_failed])
    end
  end
end