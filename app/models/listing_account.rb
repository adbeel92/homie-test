# frozen_string_literal: true

class ListingAccount < ApplicationRecord
  has_many :listing_apps, dependent: :destroy

  validates :name, presence: true
end
