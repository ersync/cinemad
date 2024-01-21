class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :profession
      t.boolean :gender
      t.date :date_of_birth
      t.string :place_of_birth
      t.integer :credits
      t.string :image_filename
      t.text :biography

      t.timestamps
    end
  end
end
