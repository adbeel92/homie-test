# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Properties', type: :request do
  let!(:property) { create(:property) }

  describe 'GET #index' do
    context 'with INVALID token' do
      it 'returns unprocessable request' do
        get '/api/v1/properties'

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with VALID token' do
      before do
        generate_token
      end

      it 'returns http success' do
        get '/api/v1/properties'

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    context 'with INVALID token' do
      it 'returns unprocessable request' do
        get "/api/v1/properties/#{property.id}"

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with VALID token' do
      before do
        generate_token
      end

      it 'returns http success' do
        get "/api/v1/properties/#{property.id}"

        expect(response).to have_http_status(:success)
      end

      it 'returns http not found' do
        get '/api/v1/properties/0'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # describe 'GET /create' do
  #   it 'returns http success' do
  #     post '/api/v1/properties'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /update' do
  #   it 'returns http success' do
  #     put '/api/v1/properties/:id'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /destroy' do
  #   it 'returns http success' do
  #     delete '/api/v1/properties/:id'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
