class Availability < ApplicationRecord
  has_many :movie_availabilities
  has_many :movies, through: :movie_availabilities
end