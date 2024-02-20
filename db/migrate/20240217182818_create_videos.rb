class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :movie, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
