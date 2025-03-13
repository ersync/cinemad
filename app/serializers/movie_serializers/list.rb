module MovieSerializers
  class List < Base
    def serialize
      {
        id: movie.id,
        slug: movie.slug,
        title: movie.title,
        release_date: movie.release_date,
        cover_url: movie.cover_url,
        average_rating: movie.average_rating,
        age_rating: movie.age_rating,
        overview: movie.overview,
        created_at: movie.created_at,
        added_to_favorites_at: movie.user_favorite_movies.order(created_at: :desc).first&.created_at,
        added_to_watchlist_at: movie.watchlist_movies.order(created_at: :desc).first&.created_at
      }
    end
  end
end