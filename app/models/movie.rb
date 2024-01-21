class Movie < ApplicationRecord
  has_one_attached :cover
  has_one_attached :background

  has_many :movie_people, dependent: :destroy
  has_many :people, through: :movie_people
  has_many :roles, through: :movie_people

  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories

  has_many :movie_keywords
  has_many :keywords, through: :movie_keywords

  def cast
    people.includes(:movie_people)
          .where(movie_people: { role_id: 1 })
          .order(created_at: :asc)
  end

end
