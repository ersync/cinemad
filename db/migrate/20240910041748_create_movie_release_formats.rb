class CreateMovieReleaseFormats < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_release_formats do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :release_format, null: false, foreign_key: true

      t.timestamps
    end
  end
end
