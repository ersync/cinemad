class AddUniqueIndexToMovieAvailabilities < ActiveRecord::Migration[7.1]
  def change
    add_index :movie_availabilities, [:movie_id, :availability_id], unique: true
  end
end
