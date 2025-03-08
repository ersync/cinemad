module MovieServices
  class MediaService
    def initialize(movie)
      @movie = movie
    end

    def posters
      @movie.posters.map { |poster| generate_blob_path(poster) }
    end

    def backdrops
      @movie.backdrops.map { |backdrop| generate_blob_path(backdrop) }
    end

    def videos
      @movie.videos.map { |video| "https://www.youtube.com/watch?v=#{video.url}" }
    end

    def popular_media
      [
        *posters.first(2),
        *backdrops.first(2),
        *videos.first(2)
      ].compact
    end

    private

    def generate_blob_path(attachment)
      Rails.application.routes.url_helpers.rails_blob_path(attachment, only_path: true)
    end
  end
end