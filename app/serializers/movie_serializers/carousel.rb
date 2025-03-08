module MovieSerializers
  class Carousel < Base
    def serialize
      {
        id: movie.id,
        slug: movie.slug,
        title: movie.title,
        release_date: movie.release_date,
        cover_url: movie.cover_url,
        average_rating: movie.average_rating
      }
    end
  end
end