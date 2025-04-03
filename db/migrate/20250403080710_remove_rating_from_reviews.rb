class RemoveRatingFromReviews < ActiveRecord::Migration[7.1]
  def up
    remove_column :reviews, :rating
  end
  
  def down
    add_column :reviews, :rating, :decimal, precision: 2, scale: 1
  end
end
