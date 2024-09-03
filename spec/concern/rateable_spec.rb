# spec/concerns/rateable_spec.rb

require 'rails_helper'

RSpec.describe Rateable, type: :concern do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  let(:dummy_class) do
    Class.new do
      include Rateable
      attr_reader :current_user, :movie

      def initialize(current_user, movie)
        @current_user = current_user
        @movie = movie
      end

      def render(options)
        options
      end

      def params
        @params ||= {}
      end
    end
  end

  subject(:controller) { dummy_class.new(user, movie) }

  let(:rating_service) { instance_double(RatingService) }

  before do
    allow(RatingService).to receive(:new).with(user, movie).and_return(rating_service)
  end

  describe '#avg_rate' do
    it 'renders JSON with average rating' do
      allow(movie).to receive(:average_rating).and_return(4.5)
      expect(controller.avg_rate).to eq({ json: { avg_rate: 4.5 } })
    end
  end

  describe '#get_rate' do
    context 'when the movie is rated' do
      it 'renders JSON with rating information' do
        allow(rating_service).to receive(:get_rate).and_return({ success: true, isRated: true, score: 4 })
        expect(controller.get_rate).to eq({ json: { success: true, isRated: true, score: 4 }, status: :ok })
      end
    end

    context 'when the movie is not rated' do
      it 'renders JSON indicating the movie is not rated' do
        allow(rating_service).to receive(:get_rate).and_return({ success: true, isRated: false })
        expect(controller.get_rate).to eq({ json: { success: true, isRated: false }, status: :ok })
      end
    end
  end

  describe '#set_rate' do
    before do
      controller.params[:rate] = 4
    end

    context 'when rating is successful' do
      it 'renders success JSON' do
        allow(rating_service).to receive(:set_rate).with(4).and_return({ success: true, isRated: true, message: "Rating updated successfully" })
        expect(controller.set_rate).to eq({ json: { success: true, isRated: true, message: "Rating updated successfully" }, status: :ok })
      end
    end

    context 'when rating fails' do
      it 'renders error JSON' do
        allow(rating_service).to receive(:set_rate).with(4).and_return({ success: false, error: "Failed to update rating" })
        expect(controller.set_rate).to eq({ json: { success: false, error: "Failed to update rating" }, status: :unprocessable_entity })
      end
    end
  end

  describe '#unrate' do
    context 'when unrating is successful' do
      it 'renders success JSON' do
        allow(rating_service).to receive(:unrate).and_return({ success: true, isRated: false, message: 'Movie unrated successfully' })
        expect(controller.unrate).to eq({ json: { success: true, isRated: false, message: 'Movie unrated successfully' }, status: :ok })
      end
    end

    context 'when unrating fails' do
      it 'renders error JSON' do
        allow(rating_service).to receive(:unrate).and_return({ success: false, isRated: true, error: 'Failed to unrate movie' })
        expect(controller.unrate).to eq({ json: { success: false, isRated: true, error: 'Failed to unrate movie' }, status: :unprocessable_entity })
      end
    end
  end
end