# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingAccount, type: :model do
  let(:listing_account) { create(:listing_account) }

  describe 'valid factory' do
    it { expect(listing_account).to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:listing_apps).dependent(:destroy) }
  end
end
