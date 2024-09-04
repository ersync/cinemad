class Collection < ApplicationRecord
  has_many :movies
  has_one_attached :background_image

  validate :acceptable_image

  private

  def acceptable_image
    return unless background_image.attached?

    unless background_image.content_type.start_with?('image/jpeg', 'image/png')
      errors.add(:background_image, 'must be a JPEG or PNG')
    end

    unless background_image.byte_size <= 1.megabyte
      errors.add(:background_image, 'is too big (should be less than 1MB)')
    end
  end
end