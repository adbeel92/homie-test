# frozen_string_literal: true

module Api
  class V1Controller < ApiController
    class AccessDenied < StandardError; end
    include ApiRenderer
    include JwtHandler

    before_action :authorized!

    rescue_from AccessDenied, with: :render_unknown_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

    def authorized!
      return if listing_authorized?

      forbidden_error(nil)
    end

    def logged_in_listing
      token = decoded_token
      return unless token

      @listing_app = ListingApp.find_by(id: token[:listing_app_id])
    end

    def listing_authorized?
      !!logged_in_listing
    end

    private

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
