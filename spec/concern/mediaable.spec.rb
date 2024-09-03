require 'rails_helper'

RSpec.describe Mediaable, type: :concern do
  let(:movie) { create(:movie) }

  let(:dummy_class) do
    Class.new do
      def self.before_action(*args)
        ;
      end

      include Mediaable

      attr_reader :movie

      def initialize(movie)
        @movie = movie
      end

      def render(options)
        options
      end
    end
  end

  subject(:controller) { dummy_class.new(movie) }

  let(:media_service) { instance_double(MovieMediaService) }

  before do
    allow(MovieMediaService).to receive(:new).with(movie).and_return(media_service)
    controller.send(:set_media_service)
  end

  describe '#get_posters' do
    context 'when posters are present' do
      let(:posters) { [{ url: 'http://example.com/poster.jpg', isVideo: false }] }

      it 'renders JSON with posters' do
        allow(media_service).to receive(:posters).and_return(posters)
        expect(controller.get_posters).to eq({ json: { success: true, urls: posters }, status: :ok })
      end
    end

    context 'when no posters are found' do
      it 'renders error JSON' do
        allow(media_service).to receive(:posters).and_return([])
        expect(controller.get_posters).to eq({ json: { success: false, error: 'No posters found for the movie' }, status: :unprocessable_entity })
      end
    end
  end

  describe '#get_backdrops' do
    context 'when backdrops are present' do
      let(:backdrops) { [{ url: 'http://example.com/backdrop.jpg', isVideo: false }] }

      it 'renders JSON with backdrops' do
        allow(media_service).to receive(:backdrops).and_return(backdrops)
        expect(controller.get_backdrops).to eq({ json: { success: true, urls: backdrops }, status: :ok })
      end
    end

    context 'when no backdrops are found' do
      it 'renders error JSON' do
        allow(media_service).to receive(:backdrops).and_return([])
        expect(controller.get_backdrops).to eq({ json: { success: false, error: 'No backdrops found for the movie' }, status: :unprocessable_entity })
      end
    end
  end

  describe '#get_videos' do
    context 'when videos are present' do
      let(:videos) { [{ url: 'http://example.com/video.mp4', isVideo: true }] }

      it 'renders JSON with videos' do
        allow(media_service).to receive(:videos).and_return(videos)
        expect(controller.get_videos).to eq({ json: { success: true, urls: videos }, status: :ok })
      end
    end

    context 'when no videos are found' do
      it 'renders error JSON' do
        allow(media_service).to receive(:videos).and_return([])
        expect(controller.get_videos).to eq({ json: { success: false, error: 'No videos found for the movie' }, status: :unprocessable_entity })
      end
    end
  end

  describe '#popular_media' do
    let(:popular_media) { [{ url: 'http://example.com/video.mp4', isVideo: true }, { url: 'http://example.com/backdrop.jpg', isVideo: false }] }

    it 'renders JSON with popular media' do
      allow(media_service).to receive(:popular_media).and_return(popular_media)
      expect(controller.popular_media).to eq({ json: { urls: popular_media }, status: :ok })
    end
  end
end