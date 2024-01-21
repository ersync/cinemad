class Role < ApplicationRecord
  has_many :movie_people
  has_many :movies, through: :movie_people
  has_many :people, through: :movie_people
end
