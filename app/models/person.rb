class Person < ApplicationRecord
  has_one_attached :image

  has_many :movie_people, dependent: :destroy
  has_many :movies, through: :movie_people
  has_many :roles, through: :movie_people
end
