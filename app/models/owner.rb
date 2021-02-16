# frozen_string_literal: true

class Owner < ApplicationRecord
  has_many :properties, dependent: :destroy

  validates :name, :phone, presence: true
end
