# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorResponse, type: :response do
  let(:args) do
    {
      title: 'No title',
      status_code: 111,
      code: 201,
      reasons: { razon: 'anything' },
      description: 'No description'
    }
  end
  let(:owner) { build(:owner) }

  subject { described_class.new(args) }

  describe '#initialize' do
    it 'returns a WarningResponse instance' do
      expect(subject).to an_instance_of(described_class)
    end

    context 'when does not have attributes' do
      it 'returns attributes' do
        expect(subject).to(
          have_attributes(
            title: 'No title',
            status_code: 111,
            reasons: { razon: 'anything' },
            description: 'No description'
          )
        )
      end
    end

    context 'when does have attributes' do
      it 'returns attributes' do
        expect(described_class.new({})).to(
          have_attributes(
            title: 'translation missing: en.error_codes',
            status_code: nil,
            reasons: {},
            description: 'An error has occurred'
          )
        )
      end
    end
  end

  describe '#to_json' do
    it 'returns a warning json' do
      expect(subject.to_json).to eq(success: false,
                                    error: {
                                      description: 'No description',
                                      message: 'No title',
                                      reasons: { razon: 'anything' }
                                    })
    end
  end

  describe '#record_not_found' do
    it 'returns not_found' do
      expect(described_class.record_not_found(owner)).to(
        have_attributes(
          title: 'Owner not found',
          status_code: :not_found,
          reasons: {},
          description: 'Owner does not exist or you do not have access'
        )
      )
    end
  end

  describe '#record_not_saved' do
    it 'returns unprocessable_entity' do
      expect(described_class.record_not_saved(owner)).to(
        have_attributes(
          title: 'Ops! Review the fields',
          status_code: :unprocessable_entity,
          reasons: {},
          description: 'Owner has incorrect values in attributes'
        )
      )
    end
  end

  describe '#record_not_destroyed' do
    context 'when does have reasons' do
      it 'returns does can not destroyed' do
        expect(described_class.record_not_destroyed(owner)).to(
          have_attributes(
            title: 'Ops! Could not be deleted',
            status_code: :unprocessable_entity,
            reasons: {},
            description: 'Record could not be deleted'
          )
        )
      end
    end

    context 'when does have reasons' do
      let(:reasons) { 'Por que sisas' }
      it 'returns does can not destroyed' do
        expect(described_class.record_not_destroyed(owner, reasons)).to(
          have_attributes(
            title: 'Ops! Could not be deleted',
            status_code: :unprocessable_entity,
            reasons: 'Por que sisas',
            description: 'Record could not be deleted'
          )
        )
      end
    end
  end

  describe '#unknown_error' do
    let(:error) { double(:base, message: 'Por que ajá') }
    it 'returns unknown_error' do
      expect(described_class.unknown_error(error)).to(
        have_attributes(
          title: 'Unknown error has occurred',
          status_code: :internal_server_error,
          reasons: { base: 'Por que ajá' },
          description: 'An error has occurred'
        )
      )
    end
  end

  describe '#not_found_error' do
    it 'returns not_found_error' do
      expect(described_class.not_found_error).to(
        have_attributes(
          title: 'Not found',
          status_code: :not_found,
          reasons: { base: 'Record could not be found' },
          description: 'An error has occurred'
        )
      )
    end
  end

  describe '#bad_request' do
    context 'when does have error message' do
      let(:error) { double(:base, messages: 'Ni idea mi fai') }

      it 'returns bad_request' do
        expect(described_class.bad_request(error)).to(
          have_attributes(
            title: 'Bad request',
            status_code: :bad_request,
            reasons: 'Ni idea mi fai',
            description: 'Review the parameters and values of the request'
          )
        )
      end
    end
  end

  describe '#unauthorized' do
    context 'when does have a message' do
      it 'returns unauthorized' do
        expect(described_class.unauthorized('Por que las cosas son asi')).to(
          have_attributes(
            title: 'Por que las cosas son asi',
            status_code: :unauthorized,
            reasons: {},
            description: 'Token is invalid or has expired'
          )
        )
      end
    end

    context 'when does have a message' do
      it 'returns unauthorized' do
        expect(described_class.unauthorized).to(
          have_attributes(
            title: 'Ops! You are not authorized to perform this action',
            status_code: :unauthorized,
            reasons: {},
            description: 'Token is invalid or has expired'
          )
        )
      end
    end
  end

  describe '#forbidden' do
    context 'when does have a message' do
      let(:error) { double(:base, message: 'Paila') }

      it 'returns forbidden' do
        expect(described_class.forbidden('Paila')).to(
          have_attributes(
            title: 'Paila',
            status_code: :forbidden,
            reasons: {},
            description: 'Token is not allowed to perform the action'
          )
        )
      end
    end

    context 'when does have a message' do
      it 'returns forbidden' do
        expect(described_class.forbidden).to(
          have_attributes(
            title: 'Ops! You are not authorized to perform this action',
            status_code: :forbidden,
            reasons: {},
            description: 'Token is not allowed to perform the action'
          )
        )
      end
    end
  end

  describe '#unprocessable_entity' do
    context 'when does have error message' do
      it 'returns unprocessable_entity' do
        expect(described_class.unprocessable_entity(error: 'Jodio')).to(
          have_attributes(
            title: 'Ops! Entity could not be processed',
            status_code: :unprocessable_entity,
            reasons: { error: 'Jodio' },
            description: 'Ops! Entity could not be processed'
          )
        )
      end
    end

    context 'when does have error message' do
      let(:error) { double(:base, messages: 'Llevado del caaarajo') }
      it 'returns unprocessable_entity' do
        expect(described_class.unprocessable_entity(error)).to(
          have_attributes(
            title: 'Ops! Entity could not be processed',
            status_code: :unprocessable_entity,
            reasons: 'Llevado del caaarajo',
            description: 'Ops! Entity could not be processed'
          )
        )
      end
    end
  end
end
