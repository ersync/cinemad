FactoryBot.define do
  factory :video do
    movie
    url { 'http://example.com/video.mp4' }
  end
end