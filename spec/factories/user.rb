FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::Internet.unique.username(specifier: 5..20) }
    password { Faker::Internet.password(min_length: 8) }

  end
end