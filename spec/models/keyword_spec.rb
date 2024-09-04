require 'rails_helper'

RSpec.describe Keyword, type: :model do
  let(:keyword) { create(:keyword) }

  describe 'associations' do
    it { is_expected.to have_many(:movie_keywords) }
    it { is_expected.to have_many(:movies).through(:movie_keywords) }
  end

  describe 'behavior' do
    it 'can have multiple movies' do
      create_list(:movie_keyword, 3, keyword: keyword)
      expect(keyword.movies.count).to eq(3)
    end

    it 'returns an empty collection of movies when there are no associations' do
      expect(keyword.movies).to be_empty
    end
  end
end