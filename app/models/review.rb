class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, inclusion: { in: [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0], message: "must be a valid rating" }

end
