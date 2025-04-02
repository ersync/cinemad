class MovieMediaSerializer
  class << self
    def serialize_posters(movie)
      MovieServices::MediaService.new(movie).posters
    end

    def serialize_backdrops(movie)
      MovieServices::MediaService.new(movie).backdrops
    end

    def serialize_videos(movie)
      MovieServices::MediaService.new(movie).videos
    end
  end
end