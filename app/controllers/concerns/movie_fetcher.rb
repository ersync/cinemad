module MovieFetcher
  extend ActiveSupport::Concern

  included do
    before_action :get_movie, except: [:index, :home]
  end

  private

  def get_movie
    @movie = Movie.find(params[:id])
  end
end