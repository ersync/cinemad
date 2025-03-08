class MovieListService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @collection = Movie.all
  end

  def fetch_movies
    MovieQueryBuilder.new(@collection)
                     .filter(@params[:filter], @current_user)
                     .sort(@params[:sort])
                     .results
  end
end