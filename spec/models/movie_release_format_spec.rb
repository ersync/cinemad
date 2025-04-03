require 'rails_helper'

RSpec.describe MovieReleaseFormat, type: :model do
  describe "associations" do
    it "belongs to movie" do
      association = MovieReleaseFormat.reflect_on_association(:movie)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to release_format" do
      association = MovieReleaseFormat.reflect_on_association(:release_format)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end