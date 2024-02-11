class WatchlistMovie < ApplicationRecord
  belongs_to :watchlist
  belongs_to :movie

  validates :watchlist_id, uniqueness: { scope: :movie_id }

end
