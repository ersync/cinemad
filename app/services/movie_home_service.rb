class MovieHomeService
  def fetch_data
    {
      trending: fetch_trending_movies,
      popular: fetch_popular_movies,
      free: fetch_free_movies
    }
  end

  private

  def fetch_trending_movies
    Movie.trending.limit(20)
  end

  def fetch_popular_movies
    Movie.popular.limit(20)
  end

  def fetch_free_movies
    Movie.free.limit(20)
  end
end