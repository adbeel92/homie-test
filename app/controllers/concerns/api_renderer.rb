# frozen_string_literal: true

module ApiRenderer
  extend ActiveSupport::Concern

  def response_success_json_format(success_response)
    render json: success_response.to_json, status: success_response.status_code
  end

  def response_error_json_format(error_response)
    render json: error_response.to_json, status: error_response.status_code
  end
end
