# frozen_string_literal: true

require 'rails_helper'

describe PropertySerializer, type: :serializer do
  let(:property) { build(:property) }
  let(:serializer) { described_class.new(property) }

  subject { serialized_json(serializer) }

  it 'should have right keys' do
    expect(subject.keys).to match_array(
      %w[
        id
        name
        description
        rental_price
        status
        owner
      ]
    )
  end
end
