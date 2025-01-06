module Mediaable
  extend ActiveSupport::Concern

  def get_posters
    render_media_response(posters, 'No posters found for the movie')
  end

  def get_backdrops
    render_media_response(backdrops, 'No backdrops found for the movie')
  end

  def get_videos
    render_media_response(videos, 'No videos found for the movie')
  end

  def popular_media
    render json: { success: true, urls: popular_media_urls }, status: :ok
  end

  private

  def posters
    @movie.posters.map do |poster|
      Rails.application.routes.url_helpers.rails_blob_path(poster, only_path: true)
    end
  end

  def backdrops
    @movie.backdrops.map do |backdrop|
      Rails.application.routes.url_helpers.rails_blob_path(backdrop, only_path: true)
    end
  end

  def videos
    @movie.videos.map do |video|
      "https://www.youtube.com/watch?v=#{video.url}"
    end
  end

  def popular_media_urls
    [
      *posters.first(2),
      *backdrops.first(2),
      *videos.first(2)
    ].compact
  end

  def render_media_response(media, error_message)
    if media.present?
      render json: { success: true, urls: media }, status: :ok
    else
      render json: { success: false, error: error_message }, status: :unprocessable_entity
    end
  end
end