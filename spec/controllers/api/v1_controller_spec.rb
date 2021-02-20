# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1Controller, type: :controller do
  controller do
    skip_before_action :authorized!

    def index
      raise Api::V1Controller::AccessDenied
    end

    def show
      raise ActiveRecord::RecordNotFound
    end
  end

  let(:listing_app) { create(:listing_app) }

  describe '#logged_in_listing' do
    it 'returns listing_app' do
      request.headers[:HTTP_X_API_KEY] = listing_app.api_key
      request.headers[:HTTP_X_API_SECRET] = listing_app.api_secret
      controller.set_listing_app
      request.headers[:Authorization] = "Bearer #{controller.encode_token}"

      expect(controller.logged_in_listing.id).to eq(listing_app.id)
    end
  end

  describe 'handling StandardError' do
    it 'renders the errors/500' do
      get :index
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'handling ActiveRecord RecordNotFound' do
    it 'renders the errors/404' do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
