require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating) { create(:rating) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:movie) }
  end

  describe 'validations' do
    subject { rating }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:movie_id) }
  end

  describe 'behavior' do
    it 'prevents duplicate ratings for the same user and movie' do
      duplicate_rating = build(:rating, user: rating.user, movie: rating.movie)
      expect(duplicate_rating).not_to be_valid
      expect(duplicate_rating.errors[:user_id]).to include(I18n.t('errors.messages.taken'))
    end
  end
end