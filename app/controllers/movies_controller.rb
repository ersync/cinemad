class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @movie = Movie.includes(:keywords).find(params[:id])
    @featured_review = @movie.reviews.first
    @crew = @movie.people
                  .includes(movie_people: :role)
                  .where.not(movie_people: { role_id: 1 })
  end

  def index

  end

  def home
    @random_movies = Movie.random_movies(12)
  end

  def new
  end

  def edit
  end
end
