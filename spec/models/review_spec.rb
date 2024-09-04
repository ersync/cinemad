require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end

  describe 'validations' do
    it { should validate_inclusion_of(:rating).in_array([0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]).with_message("must be a valid rating") }
  end

  describe 'factory' do
    it 'has a valid factory' do
      review = build(:review)
      expect(review).to be_valid, "Review is not valid: #{review.errors.full_messages.join(', ')}"
    end
  end

  describe 'rating' do
    it 'is invalid with a rating not in the list' do
      review = build(:review, rating: 0.7)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be a valid rating")
    end

    [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0].each do |valid_rating|
      it "is valid with a rating of #{valid_rating}" do
        review = build(:review, rating: valid_rating)
        expect(review).to be_valid
      end
    end
  end
end
