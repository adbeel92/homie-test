# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SuccessResponse, type: :response do
  let(:args) do
    {
      title: 'No hay titulo',
      description: 'No hay descripcion',
      status_code: 111
    }
  end

  subject { described_class.new(args) }

  describe '#initialize' do
    it 'returns an WarningResponse instance' do
      expect(subject).to an_instance_of(described_class)
    end

    it 'returns attributes' do
      expect(subject).to(
        have_attributes(
          title: 'No hay titulo',
          description: 'No hay descripcion',
          status_code: 111
        )
      )
    end
  end

  describe '#to_json' do
    it 'returns a warning json' do
      expect(subject.to_json).to eq(
        success: true,
        response: {
          message: 'No hay titulo',
          description: 'No hay descripcion'
        }
      )
    end
  end

  describe '#record_destroyed' do
    let(:owner) { build(:owner) }
    it 'returns record_destroyed' do
      expect(described_class.record_destroyed(owner)).to(
        have_attributes(
          status_code: :ok,
          title: 'Owner removido',
          description: 'Owner # ha sido eliminado con éxito'
        )
      )
    end
  end
end
