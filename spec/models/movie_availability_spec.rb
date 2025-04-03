require 'rails_helper'

RSpec.describe MovieAvailability, type: :model do
  describe "associations" do
    it "belongs to movie" do
      association = MovieAvailability.reflect_on_association(:movie)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to availability" do
      association = MovieAvailability.reflect_on_association(:availability)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "validates uniqueness of movie_id scoped to availability_id" do
      # Create a model with a validation for uniqueness
      model = MovieAvailability.new
      
      # Test that the model has the validation
      validators = MovieAvailability.validators_on(:movie_id)
      uniqueness_validator = validators.find { |v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
      
      expect(uniqueness_validator).to be_present
      expect(uniqueness_validator.options[:scope]).to eq(:availability_id)
      expect(uniqueness_validator.options[:message]).to eq("Combination of movie and availability must be unique")
    end
  end
end