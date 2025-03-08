module MovieSerializers
  class ReviewSection < Base
    def serialize
      {
        stats: {
          total_count: movie.reviews_count
        },
        featured_review: ReviewSerializer.serialize_preview(movie.featured_review)
      }
    end
  end
end