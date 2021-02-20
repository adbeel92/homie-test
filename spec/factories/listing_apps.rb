# frozen_string_literal: true

FactoryBot.define do
  factory :listing_app do
    api_key { 'abc123' }
    api_secret { 'abcdefghi123456789' }
    listing_account
  end
end
