FactoryBot.define do
  factory :movie_person do
    association :movie
    association :person
    association :role
    character_name { Faker::Name.name }
  
  end
end
