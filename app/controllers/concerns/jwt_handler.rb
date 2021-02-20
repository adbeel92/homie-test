# frozen_string_literal: true

module JwtHandler
  extend ActiveSupport::Concern

  included do
    before_action :set_listing_app
  end

  ALGORITHM = 'HS256'

  def encode_token
    return unless listing_app

    JWT.encode(
      {
        listing_app_id: listing_app.id,
        created_at: Time.current
      }, listing_app.api_secret
    )
  end

  def decoded_token
    return unless auth_header && listing_app

    begin
      body = JWT.decode(token, listing_app.api_secret, true, algorithm: ALGORITHM)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::DecodeError
      nil
    end
  end

  def set_listing_app
    @listing_app = ListingApp.find_by(api_key: api_key_header, api_secret: api_secret_header)
  end

  private

  attr_reader :listing_app

  def token
    auth_header.split[1]
  end

  def auth_header
    request.headers['Authorization']
  end

  def api_key_header
    request.headers[:HTTP_X_API_KEY]
  end

  def api_secret_header
    request.headers[:HTTP_X_API_SECRET]
  end
end
