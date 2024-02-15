class Movie < ApplicationRecord
  has_one_attached :cover
  has_one_attached :background
  has_many_attached :posters
  has_many_attached :videos
  has_many_attached :backdrops

  has_many :movie_people, dependent: :destroy
  has_many :people, through: :movie_people
  has_many :roles, through: :movie_people

  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories

  has_many :movie_keywords
  has_many :keywords, through: :movie_keywords

  has_many :reviews
  has_many :users, through: :reviews

  has_many :ratings
  has_many :users, through: :ratings

  belongs_to :collection, optional: true

  has_many :watchlist_movies
  has_many :watchlists, through: :watchlist_movies

  has_many :user_favorite_movies
  has_many :favorited_by, through: :user_favorite_movies, source: :user

  def self.random_recommendations(limit = 7)
    Movie.where(id: [4, 10, 11, 12, 13]).order('RANDOM()').limit(limit)
  end

  def cast
    people.includes(:movie_people)
          .where(movie_people: { role_id: 1 })
          .order(created_at: :asc)
  end

  def self.random_movies(limit = 12)
    offset = rand(Movie.count - limit)
    Movie.offset(offset).limit(limit)
  end

end
