# frozen_string_literal: true

class Owner < ApplicationRecord
  has_many :properties
end
