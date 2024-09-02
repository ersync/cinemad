require 'rails_helper'

RSpec.describe Favoriteable, type: :concern do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  let(:dummy_class) do
    Class.new do
      include Favoriteable
      attr_reader :current_user, :movie

      def initialize(current_user, movie)
        @current_user = current_user
        @movie = movie
      end

      def render(options)
        options
      end
    end
  end

  subject(:controller) { dummy_class.new(user, movie) }

  let(:favorite_service) { instance_double(FavoriteMovieService) }

  before do
    allow(FavoriteMovieService).to receive(:new).with(user, movie).and_return(favorite_service)
  end

  describe '#favorite_status' do
    it 'renders JSON with favorite status' do
      allow(favorite_service).to receive(:already_favorite?).and_return(true)
      expect(controller.favorite_status).to eq({ json: { isFavorite: true } })
    end
  end

  describe '#favorite' do
    context 'when favoriting is successful' do
      it 'renders success JSON with status :ok' do
        allow(favorite_service).to receive(:favorite!).and_return({ success: true, isFavorite: true })
        expect(controller.favorite).to eq({ json: { success: true, isFavorite: true }, status: :ok })
      end
    end

    context 'when favoriting fails' do
      it 'renders error JSON with status :unprocessable_entity' do
        allow(favorite_service).to receive(:favorite!).and_return({ success: false, error: 'Movie is already a favorite' })
        expect(controller.favorite).to eq({ json: { success: false, error: 'Movie is already a favorite' }, status: :unprocessable_entity })
      end
    end
  end

  describe '#unfavorite' do
    context 'when unfavoriting is successful' do
      it 'renders success JSON with status :ok' do
        allow(favorite_service).to receive(:unfavorite!).and_return({ success: true, message: 'Movie removed from favorites', isFavorite: false })
        expect(controller.unfavorite).to eq({ json: { success: true, message: 'Movie removed from favorites', isFavorite: false }, status: :ok })
      end
    end

    context 'when unfavoriting fails' do
      it 'renders error JSON with status :unprocessable_entity' do
        allow(favorite_service).to receive(:unfavorite!).and_return({ success: false, error: 'The movie was not found in favorites' })
        expect(controller.unfavorite).to eq({ json: { success: false, error: 'The movie was not found in favorites' }, status: :unprocessable_entity })
      end
    end
  end
end