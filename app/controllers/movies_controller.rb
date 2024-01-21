class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:keywords).find(params[:id])
    @crew = @movie.people
                  .includes(movie_people: :role)
                  .where.not(movie_people: { role_id: 1 })
  end

  def index
  end

  def new
  end

  def edit
  end
end
