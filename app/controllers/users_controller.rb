class UsersController < ApplicationController
  def show
  end

  def ratings
    @current_user_ratings = current_user.rated_movies
  end

  def watchlist
    @current_user_watchlist = current_user.watchlist&.movies
  end

end
