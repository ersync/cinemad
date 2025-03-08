class AddReviewsCountToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :reviews_count, :integer, default: 0, null: false
  end
end
