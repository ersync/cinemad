FactoryBot.define do
  factory :movie_category do
    association :category
    association :movie

  end
end
