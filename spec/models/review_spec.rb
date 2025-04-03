require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end

  describe "basic functionality" do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    
    it "can be created with valid attributes" do
      review = Review.new(user: user, movie: movie, content: "This was a great movie!")
      expect(review).to be_valid
    end
    
    it "requires a user" do
      review = Review.new(movie: movie, content: "Good movie")
      expect(review).not_to be_valid
    end
    
    it "requires a movie" do
      review = Review.new(user: user, content: "No movie to review")
      expect(review).not_to be_valid
    end
  end
end