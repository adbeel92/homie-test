# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApiRenderer', type: :controller do
  controller do
    include ApiRenderer

    def index
      listing_app = FactoryBot.build(:listing_app)
      success_response = SuccessResponse.record_destroyed(listing_app)
      response_success_json_format(success_response)
    end

    def show
      error_response = ErrorResponse.forbidden
      response_error_json_format(error_response)
    end
  end

  describe '#response_success_json_format' do
    it 'returns nil' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#response_error_json_format' do
    it 'returns nil' do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
