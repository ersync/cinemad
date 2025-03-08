module MovieServices
  class WatchlistService
    include Api::ApiMessages

    def initialize(user, movie)
      @user = user
      @movie = movie
    end

    def add_to_watchlist
      return ServiceResult.error(Watchlist::ERROR[:already_exists]) if in_watchlist?

      watchlist = @user.watchlist || @user.build_watchlist
      watchlist.movies << @movie

      watchlist.save ? ServiceResult.success : ServiceResult.error(Watchlist::ERROR[:add_failed])
    end

    def remove_from_watchlist
      watchlist_movie = @user.watchlist&.watchlist_movies&.find_by(movie_id: @movie.id)
      return ServiceResult.error(Watchlist::ERROR[:not_found]) unless watchlist_movie

      watchlist_movie.destroy ? ServiceResult.success : ServiceResult.error(Watchlist::ERROR[:remove_failed])
    end

    private

    def in_watchlist?
      @user.watchlist&.movies&.exists?(@movie.id)
    end
  end
end