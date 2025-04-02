require 'rails_helper'

RSpec.describe MovieMediaService, type: :service do
  let(:movie) { create(:movie) }
  subject(:service) { described_class.new(movie) }

  before do
    allow(Rails.application.routes.url_helpers).to receive(:rails_blob_url).and_return('http://example.com/media.jpg')
  end

  describe '#posters' do
    context 'when posters are present' do
      let!(:posters) { create_list(:active_storage_attachment, 2, record: movie, name: 'posters') }

      it 'returns formatted poster urls' do
        expect(service.posters.length).to eq(2)
        # expect(service.posters.first).to eq({ url: 'http://example.com/media.jpg', isVideo: false })
      end
    end

    context 'when no posters are present' do
      it 'returns an empty array' do
        expect(service.posters).to be_empty
      end
    end
  end

  describe '#backdrops' do
    context 'when backdrops are present' do
      let!(:backdrops) { create_list(:active_storage_attachment, 2, record: movie, name: 'backdrops') }

      it 'returns formatted backdrop urls' do
        expect(service.backdrops.length).to eq(2)
        expect(service.backdrops.first).to eq({ url: 'http://example.com/media.jpg', isVideo: false })
      end
    end

    context 'when no backdrops are present' do
      it 'returns an empty array' do
        expect(service.backdrops).to be_empty
      end
    end
  end

  describe '#videos' do
    context 'when videos are present' do
      let!(:videos) { create_list(:video, 2, movie: movie) }

      it 'returns formatted video urls' do
        expect(service.videos.length).to eq(2)
        expect(service.videos.first).to eq({ url: videos.first.url, isVideo: true })
      end
    end

    context 'when no videos are present' do
      it 'returns an empty array' do
        expect(service.videos).to be_empty
      end
    end
  end

end