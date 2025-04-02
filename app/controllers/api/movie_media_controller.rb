module Api
  class MovieMediaController < BaseController
    before_action :set_movie
    skip_before_action :authenticate_user!

    def posters
      render_success(
        media: MovieMediaSerializer.serialize_posters(@movie)
      )
    end

    def backdrops
      render_success(
        media: MovieMediaSerializer.serialize_backdrops(@movie)
      )
    end

    def videos
      render_success(
        media: MovieMediaSerializer.serialize_videos(@movie)
      )
    end


    private

    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end
  end
end