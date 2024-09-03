FactoryBot.define do
  factory :active_storage_blob, class: 'ActiveStorage::Blob' do
    filename { 'test.jpg' }
    byte_size { 1024 }
    checksum { SecureRandom.base64(20) }
    content_type { 'image/jpeg' }
    service_name { 'test' }
  end
end