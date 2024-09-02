class MovieMediaService
  include Rails.application.routes.url_helpers

  def initialize(movie)
    @movie = movie
  end

  def posters
    @movie.posters.map { |poster| format_media_url(poster) }
  end

  def backdrops
    @movie.backdrops.map { |backdrop| format_media_url(backdrop) }
  end

  def videos
    @movie.videos.order(:id).map { |video| { url: video.url, isVideo: true } }
  end

  def popular_media
    random_videos = @movie.videos.order(Arel.sql('RANDOM()')).limit(2).map { |video| { url: video.url, isVideo: true } }
    random_backdrops = @movie.backdrops.order(Arel.sql('RANDOM()')).limit(2).map { |backdrop| { url: rails_blob_url(backdrop, host: "localhost:3000"), isVideo: false } }
    random_videos + random_backdrops
  end

  private

  def format_media_url(media)
    { url: rails_blob_url(media, host: "localhost:3000"), isVideo: false }
  end

  def render_boolean_json(key, value)
    render json: { key => value }
  end

end