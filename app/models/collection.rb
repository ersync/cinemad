class Collection < ApplicationRecord
  has_many :movies
  has_one_attached :background_image
end
