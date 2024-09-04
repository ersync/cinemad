require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { create(:role) }

  describe 'associations' do
    it { is_expected.to have_many(:movie_people) }
    it { is_expected.to have_many(:movies).through(:movie_people) }
    it { is_expected.to have_many(:people).through(:movie_people) }
  end

  describe 'behavior' do
    it 'can have multiple movies and people' do
      create_list(:movie_person, 3, role: role)
      expect(role.movies.count).to eq(3)
      expect(role.people.count).to eq(3)
    end

    it 'returns empty collections when there are no associations' do
      expect(role.movies).to be_empty
      expect(role.people).to be_empty
    end

    it 'handles zero associations correctly' do
      expect(role.movies.count).to eq(0)
      expect(role.people.count).to eq(0)
    end
  end
end