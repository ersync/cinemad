class CreateWatchlistMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :watchlist_movies do |t|
      t.references :watchlist, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
