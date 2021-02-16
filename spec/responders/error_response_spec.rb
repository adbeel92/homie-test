# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorResponse, type: :response do
  let(:args) do
    {
      title: 'No hay titulo',
      status_code: 111,
      code: 201,
      reasons: { razon: 'Por que yes' },
      description: 'No hay descripcion'
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
            title: 'No hay titulo',
            status_code: 111,
            reasons: { razon: 'Por que yes' },
            description: 'No hay descripcion'
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
            description: 'Un error ha ocurrido'
          )
        )
      end
    end
  end

  describe '#to_json' do
    it 'returns a warning json' do
      expect(subject.to_json).to eq(success: false,
                                    error: {
                                      description: 'No hay descripcion',
                                      message: 'No hay titulo',
                                      reasons: { razon: 'Por que yes' }
                                    })
    end
  end

  describe '#record_not_found' do
    it 'returns not_found' do
      expect(described_class.record_not_found(owner)).to(
        have_attributes(
          title: 'Owner no encontrado',
          status_code: :not_found,
          reasons: {},
          description: 'Owner no existe o no tiene acceso'
        )
      )
    end
  end

  describe '#record_not_saved' do
    it 'returns unprocessable_entity' do
      expect(described_class.record_not_saved(owner)).to(
        have_attributes(
          title: 'Ups! Revisa los siguientes campos',
          status_code: :unprocessable_entity,
          reasons: {},
          description: 'Owner presenta valores incorrectos en sus atributos'
        )
      )
    end
  end

  describe '#record_not_destroyed' do
    context 'when does have reasons' do
      it 'returns does can not destroyed' do
        expect(described_class.record_not_destroyed(owner)).to(
          have_attributes(
            title: 'Ups! No se pudo eliminar',
            status_code: :unprocessable_entity,
            reasons: {},
            description: 'No se pudo eliminar el registro'
          )
        )
      end
    end

    context 'when does have reasons' do
      let(:reasons) { 'Por que sisas' }
      it 'returns does can not destroyed' do
        expect(described_class.record_not_destroyed(owner, reasons)).to(
          have_attributes(
            title: 'Ups! No se pudo eliminar',
            status_code: :unprocessable_entity,
            reasons: 'Por que sisas',
            description: 'No se pudo eliminar el registro'
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
          title: 'Un error desconocido ha ocurrido',
          status_code: :internal_server_error,
          reasons: { base: 'Por que ajá' },
          description: 'Un error ha ocurrido'
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
          reasons: { base: 'El registro no se encontró.' },
          description: 'Un error ha ocurrido'
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
            description: 'Revisa los parámetros y valores de la solicitud'
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
            description: 'El access token ha expirado o no tiene validez'
          )
        )
      end
    end

    context 'when does have a message' do
      it 'returns unauthorized' do
        expect(described_class.unauthorized).to(
          have_attributes(
            title: 'Ups! No está autorizado para realizar esta acción',
            status_code: :unauthorized,
            reasons: {},
            description: 'El access token ha expirado o no tiene validez'
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
            description: 'El rol actual no le permite realizar esta acción'
          )
        )
      end
    end

    context 'when does have a message' do
      it 'returns forbidden' do
        expect(described_class.forbidden).to(
          have_attributes(
            title: 'Ups! No está autorizado para realizar esta acción',
            status_code: :forbidden,
            reasons: {},
            description: 'El rol actual no le permite realizar esta acción'
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
            title: 'No se puede procesar la entidad',
            status_code: :unprocessable_entity,
            reasons: { error: 'Jodio' },
            description: 'No se puede procesar la entidad'
          )
        )
      end
    end

    context 'when does have error message' do
      let(:error) { double(:base, messages: 'Llevado del caaarajo') }
      it 'returns unprocessable_entity' do
        expect(described_class.unprocessable_entity(error)).to(
          have_attributes(
            title: 'No se puede procesar la entidad',
            status_code: :unprocessable_entity,
            reasons: 'Llevado del caaarajo',
            description: 'No se puede procesar la entidad'
          )
        )
      end
    end
  end
end
