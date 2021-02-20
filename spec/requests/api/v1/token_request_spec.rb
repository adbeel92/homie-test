# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  let(:listing_app) { create(:listing_app) }

  describe 'GET #create' do
    it 'returns http success' do
      post '/api/v1/token', headers: {
        HTTP_X_API_KEY: listing_app.api_key,
        HTTP_X_API_SECRET: listing_app.api_secret
      }

      expect(response).to have_http_status(:success)
      expect(parsed_response['token']).not_to be_empty
    end

    it 'returns http bad request' do
      post '/api/v1/token', headers: {
        HTTP_X_API_KEY: 'any',
        HTTP_X_API_SECRET: 'any'
      }

      expect(response).to have_http_status(:bad_request)
      expect(parsed_response['token']).to be_nil
    end
  end
end
