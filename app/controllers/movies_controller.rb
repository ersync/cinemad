class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  include MovieFetcher
  include Favoriteable
  include Watchlistable
  include Rateable
  include Mediaable
  include MovieDataHelper

  def show
    @featured_review = @movie.reviews.first
    @crew = @movie.crew_members
    @is_favorite = FavoriteMovieService.new(current_user, @movie).already_favorite? if current_user
  end

  def home
    @random_movies = Movie.all
  end

  def index
    @movies = request.post? ? fetch_filtered_and_sorted_movies : Movie.all
  end

  private

  def fetch_filtered_and_sorted_movies
    movies = filter_movies(Movie.all)
    sorted_movies, invalid_sort = sort_movies(movies)
    sorted_movies
  end

  def filter_movies(movies)
    MovieFilterService.new(movies, params, current_user).call || movies
  end

  def sort_movies(movies)
    sorted_result = MovieSorterService.new(movies, params).call
    return sorted_result if sorted_result.present?

    [movies, true] # Return original movies and indicate an invalid sort
  end

end
