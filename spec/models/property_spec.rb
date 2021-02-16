# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  let(:property) { create(:property) }

  describe 'valid factory' do
    it { expect(property).to be_valid }
  end

  describe 'valid enums' do
    it 'must have status enum with:' do
      expected_access_type_enum = {
        published: 'published', rented: 'rented', removed: 'removed'
      }

      is_expected.to define_enum_for(:status)
        .with_values(expected_access_type_enum)
        .backed_by_column_of_type(:string)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:rental_price) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:owner_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:owner) }
  end
end
