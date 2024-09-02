FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    tagline { Faker::Lorem.sentence }
    age_rating { ['G', 'PG', 'PG-13', 'R', 'NC-17'].sample }
    duration { rand(60..240) }
    release_date { Faker::Date.between(from: 50.years.ago, to: Date.today) }
    status { rand(0..5) }
    release_status { rand(0..5) }
    language { Faker::Nation.language }
    budget { Faker::Number.decimal(l_digits: 6, r_digits: 2) }
    revenue { Faker::Number.decimal(l_digits: 7, r_digits: 2) }
    overview { Faker::Lorem.paragraph(sentence_count: 3) }

    trait :with_categories do
      transient do
        categories_count { 2 }
      end

      after(:create) do |movie, evaluator|
        create_list(:category, evaluator.categories_count, movies: [movie])
      end
    end

    trait :with_keywords do
      transient do
        keywords_count { 3 }
      end

      after(:create) do |movie, evaluator|
        create_list(:keyword, evaluator.keywords_count, movies: [movie])
      end
    end
  end
end