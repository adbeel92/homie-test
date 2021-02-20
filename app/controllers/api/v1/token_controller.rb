# frozen_string_literal: true

module Api
  module V1
    class TokenController < Api::V1Controller
      skip_before_action :authorized!

      def create
        token = encode_token
        if token
          render json: { token: token }, status: :ok
        else
          response_error_json_format(ErrorResponse.bad_request(message: 'missing headers'))
        end
      end
    end
  end
end
