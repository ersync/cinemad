require 'rails_helper'

RSpec.describe RatingService do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  subject(:service) { described_class.new(user, movie) }

  describe '#get_rate' do
    context 'when the movie is rated' do
      before do
        create(:rating, user: user, movie: movie, score: 40)
      end

      it 'returns the rating information' do
        result = service.get_rate
        expect(result).to eq({ success: true, isRated: true, score: 40 })
      end
    end

    context 'when the movie is not rated' do
      it 'returns information indicating the movie is not rated' do
        result = service.get_rate
        expect(result).to eq({ success: true, isRated: false })
      end
    end
  end

  describe '#set_rate' do
    context 'when rating a movie for the first time' do
      it 'creates a new rating' do
        expect { service.set_rate(40) }.to change(Rating, :count).by(1)
      end

      it 'returns success message' do
        result = service.set_rate(40)
        expect(result).to eq({ success: true, isRated: true, message: "Rating updated successfully" })
      end
    end

    context 'when updating an existing rating' do
      before do
        create(:rating, user: user, movie: movie, score: 3)
      end

      it 'updates the existing rating' do
        expect { service.set_rate(40) }.not_to change(Rating, :count)
        expect(Rating.last.score).to eq(40)
      end

      it 'returns success message' do
        result = service.set_rate(40)
        expect(result).to eq({ success: true, isRated: true, message: "Rating updated successfully" })
      end
    end

    context 'when rating fails to save' do
      before do
        allow_any_instance_of(Rating).to receive(:save).and_return(false)
      end

      it 'returns error message' do
        result = service.set_rate(40)
        expect(result).to eq({ success: false, error: "Failed to update rating" })
      end
    end
  end

  describe '#unrate' do
    context 'when the movie is rated' do
      before do
        create(:rating, user: user, movie: movie, score: 40)
      end

      it 'removes the rating' do
        expect { service.unrate }.to change(Rating, :count).by(-1)
      end

      it 'returns success message' do
        result = service.unrate
        expect(result).to eq({ success: true, isRated: false, message: 'Movie unrated successfully' })
      end
    end

    context 'when the movie is not rated' do
      it 'returns error message' do
        result = service.unrate
        expect(result).to eq({ success: false, isRated: true, error: 'The movie was not rated' })
      end
    end

    context 'when unrating fails' do
      before do
        create(:rating, user: user, movie: movie, score: 40)
        allow_any_instance_of(Rating).to receive(:destroy).and_return(false)
      end

      it 'returns error message' do
        result = service.unrate
        expect(result).to eq({ success: false, isRated: true, error: 'Failed to unrate movie' })
      end
    end
  end

end