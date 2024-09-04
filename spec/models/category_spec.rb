require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) } # Using `create` to ensure proper database interaction

  describe 'associations' do
    it { is_expected.to have_many(:movie_categories).dependent(:destroy) }
    it { is_expected.to have_many(:movies).through(:movie_categories) }
  end

  describe 'behavior' do
    it 'returns an empty collection of movies when there are no associations' do
      expect(category.movies).to be_empty # Actual DB interaction, no mocking needed
    end

    it 'handles invalid movie_categories gracefully' do
      invalid_movie_category = build(:movie_category, category: category, movie: nil)
      expect(invalid_movie_category).not_to be_valid # Directly testing validity
      expect(category.movies.count).to eq(0)
    end

    it 'destroys associated movie_categories when deleted' do
      movie_category = create(:movie_category, category: category)
      expect { category.destroy }.to change(MovieCategory, :count).by(-1)
    end
  end
end
