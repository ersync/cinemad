FactoryBot.define do
  factory :collection do
    sequence(:name) { |n| "Collection #{n}" }
    # created_at { Time.current }
    # updated_at { Time.current }

    trait :with_movies do
      after(:create) do |collection|
        create_list(:movie, 3, collection: collection)
      end
    end
  end
end
