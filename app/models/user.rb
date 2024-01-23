class User < ApplicationRecord
  attr_accessor :terms

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :reviewed_movies, through: :reviews, source: :movie

  has_many :ratings
  has_many :rated_movies, through: :ratings, source: :movie

  has_one :watchlist

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def avg_rating
    ratings.average(:score).to_i
  end

  def to_param
    username
  end

end

