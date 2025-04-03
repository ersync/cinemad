require 'rails_helper'

RSpec.describe ReleaseFormat, type: :model do
  describe "associations" do
    it "has many movie_release_formats" do
      association = ReleaseFormat.reflect_on_association(:movie_release_formats)
      expect(association.macro).to eq(:has_many)
    end

    it "has many movies through movie_release_formats" do
      association = ReleaseFormat.reflect_on_association(:movies)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:movie_release_formats)
    end
  end
end