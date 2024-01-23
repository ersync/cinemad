class AddCollectionToMovie < ActiveRecord::Migration[7.1]
  def change
    add_reference :movies, :collection, foreign_key: true
  end
end
