module MovieServices
  class FavoriteService
    include Api::ApiMessages

    def initialize(user, movie)
      @user = user
      @movie = movie
    end

    def add_to_favorites
      return ServiceResult.error(Favorite::ERROR[:already_exists]) if already_favorite?

      @user.favorite_movies << @movie
      @user.save ? ServiceResult.success : ServiceResult.error(Favorite::ERROR[:add_failed])
    end

    def remove_from_favorites
      favorite = @user.user_favorite_movies.find_by(movie_id: @movie.id)
      return ServiceResult.error(Favorite::ERROR[:not_found]) unless favorite

      favorite.destroy ? ServiceResult.success : ServiceResult.error(Favorite::ERROR[:remove_failed])
    end

    private

    def already_favorite?
      @user.favorite_movies.exists?(id: @movie.id)
    end
  end
end