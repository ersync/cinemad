class MovieReleaseFormat < ApplicationRecord
  belongs_to :movie
  belongs_to :release_format
end