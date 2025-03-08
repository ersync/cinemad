class Keyword < ApplicationRecord
  has_many :movie_keywords
  has_many :movies, through: :movie_keywords

  class Keyword < ApplicationRecord
    scope :search_by_name, ->(query) {
      return none if query.blank?
      where("name ILIKE ?", "%#{query}%")
    }
  end
end
