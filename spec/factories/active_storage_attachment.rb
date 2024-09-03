FactoryBot.define do
  factory :active_storage_attachment, class: 'ActiveStorage::Attachment' do
    name { 'poster' }
    record { association :movie }
    blob { association :active_storage_blob }
  end
end
