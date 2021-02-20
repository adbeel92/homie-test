# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiAdmin, type: :model do
  let(:api_admin) { create(:api_admin) }

  describe 'valid factory' do
    it { expect(api_admin).to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
