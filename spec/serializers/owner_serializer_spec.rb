# frozen_string_literal: true

require 'rails_helper'

describe OwnerSerializer, type: :serializer do
  let(:owner) { build(:owner) }
  let(:serializer) { described_class.new(owner) }

  subject { serialized_json(serializer) }

  it 'should have right keys' do
    expect(subject.keys).to match_array(
      %w[
        id
        name
      ]
    )
  end
end
