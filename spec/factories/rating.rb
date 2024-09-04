FactoryBot.define do
  factory :rating do
    association :user
    association :movie
    score { [10, 20, 30, 40, 50, 60, 70, 80, 90, 100].sample }

    trait :unique_user_movie do
      after(:build) do |rating|
        while Rating.exists?(user_id: rating.user_id, movie_id: rating.movie_id)
          rating.user = create(:user)
          rating.movie = create(:movie)
        end
      end
    end
  end
end
