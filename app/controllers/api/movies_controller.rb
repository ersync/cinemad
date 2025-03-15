module Api
  class MoviesController < BaseController

    before_action :set_movie, only: [
      :show,
      :average_rating,
      :cast,
      :review_section,
      :recommendations,
    ]

    skip_before_action :authenticate_user!, only: [
      :discovery,
      :show,
      :search,
      :search_keywords,
      :home_page,
      :review_section,
      :recommendations,
      :cast,
      :average_rating
    ]

    # GET /api/movies
    # Returns paginated list of movies based on filters
    def discovery
      movies = MovieListService.new(filter_params, current_user).fetch_movies

      render_success(
        movies: MovieSerializers::List.serialize_collection(movies),
        meta: {
          total_pages: (movies.length.to_f / (params[:per_page] || 20).to_i).ceil,
          total_count: movies.length
        }
      )
    end

    # GET /api/movies/:id
    # Returns detailed movie information
    def show
      render_success(
        movie: MovieSerializers::Detailed.serialize(@movie)
      )
    end

    # GET /api/movies/home
    # Returns movie collections for home page sections
    def home_page
      render_success(
        sections: {
          trending: MovieSerializers::Carousel.serialize_collection(Movie.trending.limit(15)),
          popular: MovieSerializers::Carousel.serialize_collection(Movie.popular.limit(15)),
          latest: MovieSerializers::Carousel.serialize_collection(Movie.latest.limit(15))
        }
      )
    end

    # GET /api/movies/:id/average_rating
    # Returns movie's average rating and total ratings count
    def average_rating
      render_success(
        rating: @movie.rating_data
      )
    end

    # GET /api/movies/:id/cast
    # Returns movie's cast members with their roles
    def cast
      render_success(
        cast: MovieSerializers::Cast.serialize(@movie)
      )
    end

    # GET /api/movies/:id/review_section
    # Returns movie's featured review and review statistics
    def review_section
      render_success(
        review_section: MovieSerializers::ReviewSection.serialize(@movie)
      )
    end

    # GET /api/movies/recommendations
    # Returns personalized movie recommendations
    def recommendations
      movie = Movie.friendly.find(params[:id])
      recommendations = Movie.recommendations_for(movie)
      serialized = MovieSerializers::Recommendations.serialize_collection(recommendations)
      
      render_success(
        recommendations: serialized
      )
    end

    # GET /api/movies/search
    # Returns movies matching the search query
    def search
      movies = Movie.search_by_title(params[:query]).limit(10)
      render_success(
        results: MovieSerializers::List.serialize_collection(movies)
      )
    end

    # GET /api/movies/search_keywords
    # Returns keywords matching the search query
    def search_keywords
      keywords = Keyword.search_by_name(params[:query])
                        .limit(10)
                        .pluck(:name)

      render_success(
        keywords: keywords
      )
    end

    private

    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def filter_params
      params.permit(
        :sort,
        :page,
        :per_page,
        filter: [
          :watch_status,
          :all_availabilities,
          :all_release_formats,
          :date_from,
          :date_to,
          :language,
          { selected_keywords: [] },
          { certifications: [] },
          { availabilities: {} },
          { release_formats: [] },
          { genres: [] }
        ]
      )
    end
  end
end