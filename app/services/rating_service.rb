class RatingService
  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def get_rate
    rating = Rating.find_by(user: @user, movie: @movie)
    if rating
      { success: true, isRated: true, score: rating.score }
    else
      { success: true, isRated: false }
    end
  end

  def set_rate(score)
    rating = Rating.find_or_initialize_by(user: @user, movie: @movie)
    rating.score = score
    if rating.save
      { success: true, isRated: true, message: "Rating updated successfully" }
    else
      { success: false, error: "Failed to update rating" }
    end
  end

  def unrate
    rating = Rating.find_by(user: @user, movie: @movie)
    if rating&.destroy
      { success: true, isRated: false, message: 'Movie unrated successfully' }
    else
      { success: false, isRated: true, error: rating ? 'Failed to unrate movie' : 'The movie was not rated' }
    end
  end

end