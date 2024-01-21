class CreateMoviePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_people do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.string :character_name

      t.timestamps
    end
  end
end
