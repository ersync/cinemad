class CreateMovieAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_availabilities do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :availability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
