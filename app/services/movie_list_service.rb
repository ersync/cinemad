class MovieListService
  def initialize(params)
    @params = params
  end

  def fetch_movies
    movies = Movie.all
    movies = apply_filters(movies)
    movies = apply_sorting(movies)
    movies = apply_pagination(movies)
    movies
  end

  private

  def apply_filters(movies)
    return movies unless @params[:filter]
    MovieFilterService.new(movies, @params).call
  end

  def apply_sorting(movies)
    return movies unless @params[:sort]
    MovieSorterService.new(movies, @params).call
  end

  def apply_pagination(movies)
    page = (@params[:page] || 1).to_i
    per_page = (@params[:per_page] || 20).to_i
    movies.page(page).per(per_page)
  end
end