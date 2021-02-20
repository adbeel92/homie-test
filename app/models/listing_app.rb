# frozen_string_literal: true

class ListingApp < ApplicationRecord
  include SecureDataGenerator

  belongs_to :listing_account

  validates :listing_account_id, presence: true

  before_create :generate_api_fields

  private

  def generate_api_fields
    self.api_key = generate_api_key
    self.api_secret = generate_api_secret
  end
end
