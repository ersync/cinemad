require 'rails_helper'

RSpec.describe Availability, type: :model do
  describe "associations" do
    it "has many movie_availabilities" do
      association = Availability.reflect_on_association(:movie_availabilities)
      expect(association.macro).to eq(:has_many)
    end

    it "has many movies through movie_availabilities" do
      association = Availability.reflect_on_association(:movies)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:movie_availabilities)
    end
  end
end