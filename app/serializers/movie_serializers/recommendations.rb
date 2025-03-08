module MovieSerializers
  class Recommendations < Base
    def serialize
      {
        id: movie.id,
        slug: movie.slug,
        title: movie.title,
        background_url: movie.background_url,
        average_rating: movie.average_rating
      }
    end
  end
end