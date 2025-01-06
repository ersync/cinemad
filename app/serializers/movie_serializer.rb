class MovieSerializer
  def self.for_carousel(movie)
    {
      id: movie.id,
      title: movie.title,
      release_date: movie.release_date,
      cover_url: movie.cover_url,
      average_rating: movie.average_rating
    }
  end

  def self.detailed(movie, current_user = nil)
    {
      id: movie.id,
      title: movie.title,
      cover_url: movie.cover_url,
      background_url: movie.background_url,
      average_rating: movie.average_rating,
      release_date: movie.release_date,
      overview: movie.overview,
      crew: serialize_crew(movie),
      featured_review: serialize_review(movie),
      user_interactions: user_interactions(movie, current_user),
      age_rating: movie.age_rating,
      duration: movie.duration,
      categories: movie.categories.pluck(:name),
      gradient_color: movie.gradient_color
    }
  end

  def self.serialize_cast(movie)
    movie.cast_members.map do |cast_member|
      {
        id: cast_member.id,
        name: cast_member.name,
        image: cast_member.image_url,
        character_name: cast_member.movie_people.first.character_name
      }
    end
  end

  def self.serialize_social(movie)
    featured_review = movie.reviews.includes(:user).first

    {
      stats: {
        review_count: movie.reviews.count,
        discussion_count: 65
      },
      featured_review: featured_review ? {
        id: featured_review.id,
        content: featured_review.content[0..610] + '...',
        rating: featured_review.rating,
        created_at: featured_review.created_at.strftime("%d %B %Y"),
        user: {
          username: featured_review.user.username,
          avatar: "https://secure.gravatar.com/avatar/cbabaea0fa98692d00130498d7ac5d7c.jpg?s=45"
        }
      } : nil
    }
  end

  def self.serialize_recommendations(movies)
    movies.map do |movie|
      {
        id: movie.id,
        title: movie.title,
        background_url: movie.background_url,
        average_rating: movie.average_rating
      }
    end
  end
  private

  def self.serialize_crew(movie)
    movie.crew_members.map do |crew_member|
      {
        id: crew_member.id,
        name: crew_member.name,
        role: crew_member.movie_people.first.role.name  # Get role through movie_people
      }
    end
  end

  def self.serialize_review(movie)
    review = movie.reviews.includes(:user).first
    return nil unless review

    {
      id: review.id,
      content: review.content,
      author: review.user.username
    }
  end

  def self.for_list(movies)
    movies.map do |movie|
      {
        id: movie.id,
        title: movie.title,
        release_date: movie.release_date,
        cover_url: movie.cover_url,
        average_rating: movie.average_rating,
        overview: movie.overview,
      }
    end
  end

  def self.user_interactions(movie, user)
    return {} unless user

    {
      is_favorite: user.user_favorite_movies.exists?(movie_id: movie.id),
      in_watchlist: user.watchlist&.movies&.exists?(id: movie.id),
      user_rating: user.ratings.find_by(movie_id: movie.id)&.score
    }
  end

end