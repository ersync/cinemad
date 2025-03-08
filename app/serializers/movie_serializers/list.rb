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
        created_at: movie.created_at
      }
    end
  end
end