require 'rails_helper'

RSpec.describe FavoriteMovieService do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  subject(:service) { described_class.new(user, movie) }

  describe '#favorite!' do
    context 'when the movie is not already favorited' do
      it 'adds the movie to favorites and returns success' do
        result = service.favorite!

        expect(result[:success]).to be true
        expect(result[:isFavorite]).to be true
        expect(user.reload.favorite_movies).to include(movie)
      end
    end

    context 'when the movie is already favorited' do
      before do
        user.favorite_movies << movie
      end

      it 'returns an error message' do
        result = service.favorite!

        expect(result[:success]).to be false
        expect(result[:error]).to eq('Movie is already a favorite')
        expect(user.reload.favorite_movies.count).to eq(1)
      end
    end

    context 'when saving fails' do
      before do
        allow(user).to receive(:save).and_return(false)
      end

      it 'returns an error message' do
        result = service.favorite!

        expect(result[:success]).to be false
        expect(result[:error]).to eq('Failed to add movie to favorites')
      end
    end
  end

  describe '#unfavorite!' do
    context 'when the movie is in favorites' do
      before do
        user.favorite_movies << movie
      end

      it 'removes the movie from favorites and returns success' do
        result = service.unfavorite!

        expect(result[:success]).to be true
        expect(result[:isFavorite]).to be false
        expect(user.reload.favorite_movies).not_to include(movie)
      end
    end

    context 'when the movie is not in favorites' do
      it 'returns an error message' do
        result = service.unfavorite!

        expect(result[:success]).to be false
        expect(result[:error]).to eq('The movie was not found in favorites')
      end
    end

    context 'when removing fails' do
      before do
        user.favorite_movies << movie
        allow_any_instance_of(UserFavoriteMovie).to receive(:destroy).and_return(false)
      end

      it 'returns an error message' do
        result = service.unfavorite!

        expect(result[:success]).to be false
        expect(result[:error]).to eq('Failed to remove movie from favorites')
      end
    end
  end

  describe '#already_favorite?' do
    context 'when the movie is already favorited' do
      before do
        user.favorite_movies << movie
      end

      it 'returns true' do
        expect(service.already_favorite?).to be true
      end
    end

    context 'when the movie is not favorited' do
      it 'returns false' do
        expect(service.already_favorite?).to be false
      end
    end
  end
end