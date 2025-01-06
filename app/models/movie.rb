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

  has_many :movie_availabilities
  has_many :availabilities, through: :movie_availabilities

  has_many :movie_release_formats
  has_many :release_formats, through: :movie_release_formats

  belongs_to :collection, optional: true

  has_many :watchlist_movies
  has_many :watchlists, through: :watchlist_movies

  has_many :user_favorite_movies
  has_many :favorited_by, through: :user_favorite_movies, source: :user

  has_many :videos

  scope :seen, ->(user_id) { joins(:ratings).where(ratings: { user_id: user_id }) }
  scope :unseen, ->(user_id) {
    where.not(id: Rating.where(user_id: user_id).select(:movie_id))
  }
  scope :random, ->(limit = 12) { offset(rand(count - limit)).limit(limit) }
  scope :random_recommendations, ->(limit = 7) { where(id: [4, 10, 11, 12, 13]).order(Arel.sql('RANDOM()')).limit(limit) }

  scope :by_genres, ->(genres) {
    joins(:categories).where(categories: { name: genres }) if genres.present?
  }

  scope :by_language, ->(language) {
    where(language: language) if language.present?
  }

  scope :sort_by_field, ->(sort_by) {
    case sort_by
    when 'popularity_desc'
      order(revenue: :desc)
    when 'popularity_asc'
      order(revenue: :asc)
    when 'rating_desc', 'rating_asc'
      select('movies.*, COALESCE(AVG(ratings.score), 0) as avg_rating')
        .left_joins(:ratings)
        .group('movies.id')
        .order("avg_rating #{sort_by.ends_with?('desc') ? 'DESC' : 'ASC'}")
    when 'release_date_desc'
      order(release_date: :desc)
    when 'release_date_asc'
      order(release_date: :asc)
    when 'title_desc'
      order(title: :desc)
    when 'title_asc'
      order(title: :asc)
    else
      order(:id)
    end
  }

  def crew_members
    people.includes(movie_people: :role).where.not(movie_people: { movie_people: { role_id: 1 } })
  end

  def cast_members
    people.includes(:movie_people)
          .where(movie_people: { role_id: 1 })
          .order(created_at: :asc)
  end

  def average_rating
    ratings.average(:score).to_i || 0
  end

  # def self.filter_and_sort(sort_by)
  #   MovieSorter.new(sort_by).call
  # end


  def cover_url
    return nil unless cover.attached?

    Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true)
  end

  # You might also want background_url
  def background_url
    if background.attached?
      Rails.application.routes.url_helpers.rails_blob_path(background, only_path: true)
    else
      nil
    end
  end

end
