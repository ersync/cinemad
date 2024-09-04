FactoryBot.define do
  factory :review do
    association :user
    association :movie
    rating { [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0].sample }
    content { Faker::Lorem.paragraph(sentence_count: 3) }

    # If you need created_at and updated_at to be set explicitly:
    # created_at { Time.current }
    # updated_at { Time.current }
  end
end
