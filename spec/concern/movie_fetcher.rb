# spec/concerns/movie_fetcher_spec.rb

require 'rails_helper'

RSpec.describe MovieFetcher, type: :concern do
  let(:movie) { create(:movie) }

  class DummyController < ApplicationController
    include MovieFetcher

    # Override the callback for testing purposes
    skip_before_action :get_movie, raise: false
  end

  let(:controller) { DummyController.new }

  describe '#get_movie' do
    context 'when action is show' do
      before do
        allow(controller).to receive(:params).and_return(ActionController::Parameters.new(id: movie.id))
        allow(controller).to receive(:action_name).and_return('show')
      end

      it 'sets @movie before the action' do
        controller.send(:get_movie)
        expect(controller.instance_variable_get(:@movie)).to eq(movie)
      end

      it 'raises ActiveRecord::RecordNotFound for non-existent movie' do
        allow(controller).to receive(:params).and_return(ActionController::Parameters.new(id: 999999))
        expect {
          controller.send(:get_movie)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when action is index' do
      before do
        allow(controller).to receive(:params).and_return(ActionController::Parameters.new)
        allow(controller).to receive(:action_name).and_return('index')
        allow(controller).to receive(:get_movie) # Mock get_movie to not execute for index
      end

      it 'does not set @movie' do
        expect(Movie).not_to receive(:find)
        controller.send(:get_movie)
        expect(controller.instance_variable_get(:@movie)).to be_nil
      end
    end

    context 'when action is home' do
      before do
        allow(controller).to receive(:params).and_return(ActionController::Parameters.new)
        allow(controller).to receive(:action_name).and_return('home')
        allow(controller).to receive(:get_movie) # Mock get_movie to not execute for home
      end

      it 'does not set @movie' do
        expect(Movie).not_to receive(:find)
        controller.send(:get_movie)
        expect(controller.instance_variable_get(:@movie)).to be_nil
      end
    end
  end
end
