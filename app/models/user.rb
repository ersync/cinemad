class User < ApplicationRecord
  attr_accessor :terms
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :reviewed_movies, through: :reviews, source: :movie

  has_many :ratings, dependent: :destroy
  has_many :rated_movies, through: :ratings, source: :movie

  has_one :watchlist, dependent: :destroy

  has_many :user_favorite_movies, dependent: :destroy
  has_many :favorite_movies, through: :user_favorite_movies, source: :movie

  validates :username, presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 6, message: "must be at least 6 characters" }

  validates :bio, length: { maximum: 500 }, allow_blank: true

  validate :validate_avatar, if: -> { avatar.attached? }

  def movies_to_watch
    return Movie.none unless watchlist
    watchlist.movies
  end

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    end
  end

  def avg_rating
    ratings.average(:score).to_i
  end

  def to_param
    username
  end

  private

  def validate_avatar
    unless avatar.content_type.in?(%w[image/jpeg image/png])
      errors.add(:avatar, 'must be a JPEG or PNG')
    end

    unless avatar.byte_size <= 2.megabytes
      errors.add(:avatar, 'size should be less than 2MB')
    end
  end

end

