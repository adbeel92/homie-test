# frozen_string_literal: true

module Api
  class V1Controller < ApplicationController
    include ApiRenderer

    rescue_from StandardError, with: :render_unknown_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

    def render_unknown_error(error)
      response_error_json_format ErrorResponse.unknown_error(error)
    end

    def render_not_found_error
      response_error_json_format ErrorResponse.not_found_error
    end

    def forbidden_error(_error)
      response_error_json_format ErrorResponse.forbidden
    end
  end
end
