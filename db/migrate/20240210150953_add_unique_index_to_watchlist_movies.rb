class AddUniqueIndexToWatchlistMovies < ActiveRecord::Migration[7.1]
  def change
    add_index :watchlist_movies, [:watchlist_id, :movie_id], unique: true
  end
end
