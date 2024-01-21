class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :tagline
      t.string :age_rating
      t.integer :duration
      t.date :release_date
      t.integer :status
      t.integer :release_status
      t.string :language
      t.decimal :budget
      t.string :revenue
      t.string :image_filename
      t.string :gradient_color
      t.text :overview

      t.timestamps
    end
  end
end
