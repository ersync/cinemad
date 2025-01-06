class ReleaseFormat < ApplicationRecord
  has_many :movie_release_formats
  has_many :movies, through: :movie_release_formats
end