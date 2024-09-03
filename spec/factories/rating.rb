# spec/factories/ratings.rb

FactoryBot.define do
  factory :rating do
    association :user
    association :movie
    score { [10, 20, 30, 40, 50, 60, 70, 80, 90, 100].sample }
  end
end