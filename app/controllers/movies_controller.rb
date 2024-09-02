class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  include MovieFetcher
  include Favoriteable
  include Watchlistable
  include Rateable
  include Mediaable

  def show
    @featured_review = @movie.reviews.first
    @crew = @movie.crew_members
    @is_favorite = FavoriteMovieService.new(current_user, @movie).already_favorite? if current_user
  end

  def home
    @random_movies = Movie.random_movies(12)
  end

end
