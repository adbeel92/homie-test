# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Owner, type: :model do
  let(:owner) { create(:owner) }

  describe 'valid factory' do
    it { expect(owner).to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:properties).dependent(:destroy) }
  end
end
