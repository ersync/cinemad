class MovieAvailability < ApplicationRecord
  belongs_to :movie
  belongs_to :availability

  validates :movie_id, uniqueness: { scope: :availability_id, message: "Combination of movie and availability must be unique" }

end
