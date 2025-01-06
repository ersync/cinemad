module Api
  class MoviesController < ApplicationController
    include Favoriteable
    include Watchlistable
    include Rateable
    include Mediaable
    include MovieDataHelper

    before_action :set_movie, only: [
      :show,
      :avg_rate,
      # Favorite
      :favorite_status,
      :favorite,
      :unfavorite,
      # Watchlist
      :in_watchlist_status,
      :add_to_watchlist,
      :remove_from_watchlist,
      # Rating
      :get_rate,
      :set_rate,
      :unrate,
      # Media
      :get_posters,
      :get_backdrops,
      :get_videos,
      :popular_media,
      # Cast
      :cast,
      # Social
      :social,
      # Recommendations
      :recommendations
    ]

    skip_before_action :verify_authenticity_token

    def index
      movies = MovieListService.new(filter_params).fetch_movies
      render json: MovieSerializer.for_list(movies)
    end

    def show
      render json: MovieSerializer.detailed(@movie, current_user)
    end

    def home_data
      render json: {
        trending: Movie.trending.limit(20).map { |m| MovieSerializer.for_carousel(m) },
        popular: Movie.popular.limit(20).map { |m| MovieSerializer.for_carousel(m) },
        free: Movie.free.limit(20).map { |m| MovieSerializer.for_carousel(m) }
      }
    end

    def avg_rate
      render json: {
        average_rating: @movie.average_rating,
        total_ratings: @movie.ratings.count
      }
    end

    def cast
      render json: MovieSerializer.serialize_cast(@movie)
    end

    def social
      render json: MovieSerializer.serialize_social(@movie)
    end

    def recommendations
      recommendations = Movie.random_recommendations
      render json: MovieSerializer.serialize_recommendations(recommendations)
    end

    private

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def filter_params
      params.permit(:sort, :filter, :page, :per_page, :query)
    end
  end
end