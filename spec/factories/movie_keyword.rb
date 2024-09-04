FactoryBot.define do
  factory :movie_keyword do
    association :movie
    association :keyword

    # created_at { Time.current }
    # updated_at { Time.current }
  end
end
