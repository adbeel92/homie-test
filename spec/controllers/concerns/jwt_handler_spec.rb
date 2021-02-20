# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'JwtHandler', type: :controller do
  controller do
    include JwtHandler
  end

  let!(:listing_app) { create(:listing_app) }

  describe '#encode_token' do
    it 'returns token' do
      request.headers[:HTTP_X_API_KEY] = listing_app.api_key
      request.headers[:HTTP_X_API_SECRET] = listing_app.api_secret

      controller.set_listing_app
      expect(controller.encode_token).not_to be_empty
    end

    it 'returns nil' do
      request.headers[:HTTP_X_API_KEY] = 'test'
      request.headers[:HTTP_X_API_SECRET] = 'test'

      controller.set_listing_app
      expect(controller.encode_token).to be_nil
    end
  end

  describe '#decoded_token' do
    it 'returns payload' do
      request.headers[:HTTP_X_API_KEY] = listing_app.api_key
      request.headers[:HTTP_X_API_SECRET] = listing_app.api_secret
      controller.set_listing_app
      request.headers[:Authorization] = "Bearer #{controller.encode_token}"

      expect(controller.decoded_token).not_to be_empty
    end

    it 'returns nil with invalid api key and secret' do
      request.headers[:HTTP_X_API_KEY] = 'test'
      request.headers[:HTTP_X_API_SECRET] = 'test'
      request.headers[:Authorization] = "Bearer #{controller.encode_token}"

      controller.set_listing_app
      expect(controller.decoded_token).to be_nil
    end

    it 'returns nil invalid token' do
      request.headers[:HTTP_X_API_KEY] = listing_app.api_key
      request.headers[:HTTP_X_API_SECRET] = listing_app.api_secret
      request.headers[:Authorization] = 'Bearer abc123'

      controller.set_listing_app
      expect(controller.decoded_token).to be_nil
    end
  end
end
