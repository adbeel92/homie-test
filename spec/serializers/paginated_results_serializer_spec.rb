# frozen_string_literal: true

require 'rails_helper'

describe PaginatedResultsSerializer, type: :serializer do
  let(:properties) do
    build_list(:property, 3)
  end
  let(:paginated_collection) do
    ApiPagination.paginate(
      properties,
      page: 1,
      per_page: 10
    )
  end
  let(:serializer) do
    described_class.new(
      collection: paginated_collection,
      each_serializer: PropertySerializer
    )
  end

  subject { serialized_json(serializer) }

  it 'should have right keys' do
    expect(subject.keys).to match_array(%w[results meta])
  end

  describe '#results' do
    it 'returns an instance' do
      expect(serializer.results.first).to an_instance_of(PropertySerializer)
    end
  end

  describe '#meta' do
    it 'returns meta' do
      expect(serializer.meta).to(
        eq(
          total: 3,
          current_page: 1,
          first_page: true,
          last_page: true,
          next_page: nil,
          prev_page: nil,
          total_pages: 1
        )
      )
    end
  end
end
