module Watchlistable
  extend ActiveSupport::Concern

  def in_watchlist_status
    isInWatchlist = watchlist_service.in_watchlist?
    render json: { isInWatchlist: isInWatchlist }
  end

  def add_to_watchlist
    result = watchlist_service.watchlist!
    render_result(result)
  end

  def remove_from_watchlist
    result = watchlist_service.unwatchlist!
    render_result(result)
  end

  private

  def render_result(result)
    render json: result, status: result[:success] ? :ok : :unprocessable_entity
  end
  
  def watchlist_service
    @watchlist_service ||= WatchlistService.new(current_user, @movie)
  end

end