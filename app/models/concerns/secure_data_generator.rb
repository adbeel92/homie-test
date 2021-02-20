# frozen_string_literal: true

module SecureDataGenerator
  extend ActiveSupport::Concern

  def generate_api_key
    SecureRandom.base64.tr('+/=', 'Qrt')
  end

  def generate_api_secret
    SecureRandom.hex(64)
  end
end
