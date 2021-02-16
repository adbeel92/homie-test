# frozen_string_literal: true

class ErrorResponse
  attr_reader :title, :reasons, :description, :status_code

  def initialize(args)
    @title = args[:title] || I18n.t("error_codes.#{args[:code]}")
    @status_code = args[:status_code]
    @reasons = args[:reasons] || {}
    @description = args[:description] || 'Un error ha ocurrido'
  end

  def to_json(*_args)
    {
      success: false,
      error: {
        message: title,
        reasons: reasons,
        description: description
      }
    }
  end

  def self.record_not_found(klass)
    new(
      title: "#{klass.model_name.human} no encontrado",
      description: "#{klass.model_name.human} no existe o no tiene acceso",
      status_code: :not_found
    )
  end

  def self.record_not_saved(record, reasons = nil)
    new(
      title: 'Ups! Revisa los siguientes campos',
      description: "#{record.class.model_name.human} presenta valores incorrectos en sus atributos",
      reasons: reasons || record.errors.messages,
      status_code: :unprocessable_entity
    )
  end

  def self.record_not_destroyed(record, reasons = nil)
    new(
      title: 'Ups! No se pudo eliminar',
      description: 'No se pudo eliminar el registro',
      reasons: reasons || record.errors.messages,
      status_code: :unprocessable_entity
    )
  end

  def self.unknown_error(error)
    new(
      title: 'Un error desconocido ha ocurrido',
      reasons: { base: error.message },
      status_code: :internal_server_error
    )
  end

  def self.not_found_error
    new(
      title: 'Not found',
      reasons: { base: 'El registro no se encontró.' },
      status_code: :not_found
    )
  end

  def self.bad_request(error = nil)
    new(
      title: 'Bad request',
      description: 'Revisa los parámetros y valores de la solicitud',
      reasons: error.is_a?(Hash) ? error : error.messages,
      status_code: :bad_request
    )
  end

  def self.unauthorized(message = nil)
    new(
      title: message || 'Ups! No está autorizado para realizar esta acción',
      description: 'El access token ha expirado o no tiene validez',
      status_code: :unauthorized
    )
  end

  def self.forbidden(message = nil)
    new(
      title: message || 'Ups! No está autorizado para realizar esta acción',
      description: 'El rol actual no le permite realizar esta acción',
      status_code: :forbidden
    )
  end

  def self.unprocessable_entity(error = nil)
    new(
      title: 'No se puede procesar la entidad',
      description: 'No se puede procesar la entidad',
      reasons: error.is_a?(Hash) ? error : error.messages,
      status_code: :unprocessable_entity
    )
  end
end
