# frozen_string_literal: true

class PropertySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :rental_price, :status

  belongs_to :owner
end
