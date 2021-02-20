# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingApp, type: :model do
  let(:listing_app) { create(:listing_app) }

  describe 'valid factory' do
    it { expect(listing_app).to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:listing_account_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:listing_account) }
  end
end
