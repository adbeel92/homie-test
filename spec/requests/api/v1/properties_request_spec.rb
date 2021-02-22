# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Properties', type: :request do
  let!(:property) { create(:property) }
  let(:owner) { create(:owner) }

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

  describe 'POST #create' do
    context 'with INVALID token' do
      it 'returns unprocessable request' do
        post '/api/v1/properties'

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with VALID token' do
      before do
        generate_token
      end

      it 'returns http success' do
        post '/api/v1/properties', params: {
          property: {
            name: 'Departamento en Condesa',
            description: 'Perfectamente ubicado, cerca de restaurantes y bares',
            rental_price: 21_000,
            status: 'published',
            owner_id: owner.id
          }
        }

        expect(response).to have_http_status(:success)
      end

      it 'returns http unprocessable entity' do
        post '/api/v1/properties', params: {
          property: {
            name: 'Departamento en Condesa',
            description: 'Perfectamente ubicado, cerca de restaurantes y bares',
            rental_price: 21_000,
            status: 'any',
            owner_id: owner.id
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with INVALID token' do
      it 'returns unprocessable request' do
        put "/api/v1/properties/#{property.id}"

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with VALID token' do
      before do
        generate_token
      end

      it 'returns http success' do
        put "/api/v1/properties/#{property.id}", params: {
          property: {
            status: (Property.statuses.keys - [property.status]).first
          }
        }

        expect(response).to have_http_status(:success)
      end

      it 'returns http unprocessable entity' do
        put "/api/v1/properties/#{property.id}", params: {
          property: {
            status: 'any'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns http unprocessable entity (same status)' do
        put "/api/v1/properties/#{property.id}", params: {
          property: {
            status: property.status
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns http not found' do
        put '/api/v1/properties/0'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with INVALID token' do
      it 'returns unprocessable request' do
        delete "/api/v1/properties/#{property.id}"

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with VALID token' do
      before do
        generate_token
      end

      let(:property_to_delete) { create(:property) }

      it 'returns http success' do
        delete "/api/v1/properties/#{property_to_delete.id}"

        expect(response).to have_http_status(:success)
      end

      it 'returns http unprocessable entity' do
        allow_any_instance_of(Properties::Operations::Destroy).to receive(:run).and_return(false)

        delete "/api/v1/properties/#{property_to_delete.id}"

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns http not found' do
        delete '/api/v1/properties/0'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
