module Mediaable
  extend ActiveSupport::Concern

  included do
    before_action :set_media_service, only: [:get_posters, :get_backdrops, :get_videos, :popular_media]
  end

  def get_posters
    render_media_response(@media_service.posters, 'No posters found for the movie')
  end

  def get_backdrops
    render_media_response(@media_service.backdrops, 'No backdrops found for the movie')
  end

  def get_videos
    render_media_response(@media_service.videos, 'No videos found for the movie')
  end

  def popular_media
    render json: { urls: @media_service.popular_media }, status: :ok
  end

  private

  def set_media_service
    @media_service = MovieMediaService.new(@movie)
  end

  def render_media_response(media, error_message)
    if media.present?
      render json: { success: true, urls: media }, status: :ok
    else
      render json: { success: false, error: error_message }, status: :unprocessable_entity
    end
  end

end