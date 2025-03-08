module MovieSerializers
  class Detailed < Base
    def serialize
      {
        id: movie.id,
        slug: movie.slug,
        title: movie.title,
        status: movie.status,
        language: movie.language,
        budget: movie.budget,
        revenue: movie.revenue,
        cover_url: movie.cover_url,
        background_url: movie.background_url,
        average_rating: movie.average_rating,
        release_date: movie.release_date,
        overview: movie.overview,
        crew: CrewSerializer.serialize_collection(
          movie.crew_members
               .includes(:movie_people, movie_people: :role)
               .distinct),
        reviews_section: {
        stats: {
        total_count: movie.reviews.count
      },
        featured_review: ReviewSerializer.serialize_preview(movie.featured_review)
      },
        age_rating: movie.age_rating,
        tagline: movie.tagline,
        duration: movie.duration,
        categories: movie.categories.pluck(:name),
        gradient_color: movie.gradient_color
      }
    end
  end
end