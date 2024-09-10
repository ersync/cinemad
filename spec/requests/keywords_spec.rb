require 'rails_helper'

RSpec.describe "Keywords", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/keywords/search"
      expect(response).to have_http_status(:success)
    end
  end

end
