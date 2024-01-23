class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.decimal :rating, precision: 2, scale: 1
      t.timestamps
      t.text :content
    end
  end
end
