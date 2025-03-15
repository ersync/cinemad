class Movie < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  # Validations
  validates :title, :release_date, :age_rating, presence: true

  # Active Storage Attachments
  has_one_attached :cover
  has_one_attached :background
  has_many_attached :posters
  has_many_attached :backdrops

  # Associations
  belongs_to :collection, optional: true

  # People & Roles
  has_many :movie_people, dependent: :destroy
  has_many :people, through: :movie_people
  has_many :roles, through: :movie_people

  # Categories & Keywords
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories
  has_many :movie_keywords
  has_many :keywords, through: :movie_keywords

  # User Interactions
  has_many :reviews, dependent: :destroy, counter_cache: true
  has_many :ratings
  has_many :users, through: :ratings
  has_many :watchlist_movies
  has_many :watchlists, through: :watchlist_movies
  has_many :user_favorite_movies
  has_many :favorited_by, through: :user_favorite_movies, source: :user

  # Movie Details
  has_many :movie_availabilities
  has_many :availabilities, through: :movie_availabilities
  has_many :movie_release_formats
  has_many :release_formats, through: :movie_release_formats
  has_many :videos, dependent: :destroy

  # Scopes - Reviews
  def featured_review
    reviews.includes(:user, user: :ratings).first
  end

  # Scopes - Discovery
  scope :trending, -> {
    joins(:reviews)
      .group('movies.id')
      .order('COUNT(reviews.id) DESC')
  }

  scope :popular, -> {
    joins(:ratings)
      .group('movies.id')
      .order('AVG(ratings.score) DESC')
  }

  scope :latest, -> { order(release_date: :desc) }

  # Scopes - Search & Filtering
  scope :search_by_title, ->(query) {
    return none if query.blank?
    where("title ILIKE ?", "%#{query}%")
  }

  scope :by_genres, ->(genres) {
    joins(:categories).where(categories: { name: genres }) if genres.present?
  }

  scope :by_language, ->(language) {
    where(language: language) if language.present?
  }

  # Scopes - User Related
  scope :watched_by, ->(user_id) {
    joins(:ratings).where(ratings: { user_id: user_id }).distinct
  }

  scope :unwatched_by, ->(user_id) {
    where.not(id: Rating.where(user_id: user_id).select(:movie_id).distinct)
  }

  # Scopes - Random Selection
  scope :random, ->(limit = 12) { offset(rand(count - limit)).limit(limit) }

  # Instance Methods - Cast & Crew
  def cast_members
    people.includes(:movie_people)
          .where(movie_people: { role_id: 1 })
          .order('movie_people.created_at ASC')
  end

  def crew_members
    people.includes(:movie_people)
          .where(movie_people: { movie_id: id })
          .where.not(movie_people: { role_id: 1 })
  end

  # Instance Methods - URLs
  def cover_url
    return nil unless cover.attached?
    Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true)
  end

  def background_url
    return nil unless background.attached?
    Rails.application.routes.url_helpers.rails_blob_path(background, only_path: true)
  end

  # Instance Methods - Ratings
  def average_rating
    ratings.average(:score)&.round || 0
  end

  def rating_data
    {
      average_rating: average_rating,
      total_ratings: ratings.count
    }
  end

  private

  def slug_candidates
    [
      [:title, :release_year],
      [:title, :release_year, -> { SecureRandom.hex(4) }]
    ]
  end

  def release_year
    release_date.year if release_date
  end
  
  def self.recommendations_for(movie, limit = 7)
    movie_category_ids = movie.categories.pluck(:id)
    
    movie_match_counts = MovieCategory
      .where(category_id: movie_category_ids)
      .where.not(movie_id: movie.id)
      .group(:movie_id)
      .order('count_category_id DESC')
      .limit(limit)
      .count(:category_id)
    
    movie_ids = movie_match_counts.keys
    
    if movie_ids.length < limit
      additional_ids = Movie
        .where.not(id: movie_ids + [movie.id])
        .order(Arel.sql('RANDOM()'))
        .limit(limit - movie_ids.length)
        .pluck(:id)
      
      movie_ids = movie_ids + additional_ids
    end
    
    movies = Movie.where(id: movie_ids).index_by(&:id)
    
    movie_ids.map { |id| movies[id] }.compact
  end
  

end