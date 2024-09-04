require 'rails_helper'

RSpec.describe Collection, type: :model do
  let(:collection) { create(:collection) }

  describe 'associations' do
    it { is_expected.to have_many(:movies) }
    it { is_expected.to have_one_attached(:background_image) }
  end

  describe 'behavior' do
    it 'can have multiple movies' do
      create_list(:movie, 3, collection: collection)
      expect(collection.movies.count).to eq(3)
    end

    context 'with background image' do
      before do
        collection.background_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
          filename: 'test_image.jpg',
          content_type: 'image/jpeg'
        )
      end

      it 'has an attached background image' do
        expect(collection.background_image).to be_attached
      end

      it 'has the correct content type' do
        expect(collection.background_image.content_type).to eq('image/jpeg')
      end

      it 'rejects non-image files' do
        file = Tempfile.new(['test', '.txt'])
        file.write('This is not an image')
        file.rewind

        collection.background_image.attach(io: file, filename: 'test.txt', content_type: 'text/plain')
        expect(collection).not_to be_valid
        expect(collection.errors[:background_image]).to include('must be a JPEG or PNG')

        file.close
        file.unlink
      end

      it 'rejects large images' do
        large_file = Tempfile.new(['large_image', '.jpg'])
        large_file.write('0' * 2.megabytes) # Create a file larger than 1MB
        large_file.rewind

        collection.background_image.attach(io: large_file, filename: 'large_image.jpg', content_type: 'image/jpeg')
        expect(collection).not_to be_valid
        expect(collection.errors[:background_image]).to include('is too big (should be less than 1MB)')

        large_file.close
        large_file.unlink
      end
    end
  end
end
