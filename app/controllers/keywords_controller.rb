class KeywordsController < ApplicationController
  def search
    query = params[:q].to_s.downcase
    keywords = Keyword.where('LOWER(name) LIKE ?', "%#{query}%").limit(10)
    render json: keywords.pluck(:name)
  end
end
