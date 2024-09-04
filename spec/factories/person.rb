FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    profession { Faker::Job.title }
    gender { [true, false].sample }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 100) }
    place_of_birth { Faker::Address.city }
    credits { Faker::Number.between(from: 1, to: 100) }
    image_filename { "person_#{Faker::Number.number(digits: 10)}.jpg" }
    biography { Faker::Lorem.paragraphs(number: 3).join("\n\n") }

    trait :with_image do
      after(:build) do |person|
        person.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
          filename: 'test_image.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

  end
end
