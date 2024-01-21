class Keyword < ApplicationRecord
  has_many :movie_keywords
  has_many :movies, through: :movie_keywords
end
