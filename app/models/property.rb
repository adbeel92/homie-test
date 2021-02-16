# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :owner

  enum status: { published: 'published', rented: 'rented', removed: 'removed' }

  validates :name, :rental_price, :status, :owner_id, presence: true
end
