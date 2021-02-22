# frozen_string_literal: true

class ErrorResponse
  attr_reader :title, :reasons, :description, :status_code

  def initialize(args)
    @title = args[:title] || I18n.t("error_codes.#{args[:code]}")
    @status_code = args[:status_code]
    @reasons = args[:reasons] || {}
    @description = args[:description] || 'An error has occurred'
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
      title: "#{klass.model_name.human} not found",
      description: "#{klass.model_name.human} does not exist or you do not have access",
      status_code: :not_found
    )
  end

  def self.record_not_saved(record, reasons = nil)
    new(
      title: 'Ops! Review the fields',
      description: "#{record.class.model_name.human} has incorrect values in attributes",
      reasons: reasons || record.errors.messages,
      status_code: :unprocessable_entity
    )
  end

  def self.record_not_destroyed(record, reasons = nil)
    new(
      title: 'Ops! Could not be deleted',
      description: 'Record could not be deleted',
      reasons: reasons || record.errors.messages,
      status_code: :unprocessable_entity
    )
  end

  def self.unknown_error(error)
    new(
      title: 'Unknown error has occurred',
      reasons: { base: error.message },
      status_code: :internal_server_error
    )
  end

  def self.not_found_error
    new(
      title: 'Not found',
      reasons: { base: 'Record could not be found' },
      status_code: :not_found
    )
  end

  def self.bad_request(error = nil)
    new(
      title: 'Bad request',
      description: 'Review the parameters and values of the request',
      reasons: error.is_a?(Hash) ? error : error.messages,
      status_code: :bad_request
    )
  end

  def self.unauthorized(message = nil)
    new(
      title: message || 'Ops! You are not authorized to perform this action',
      description: 'Token is invalid or has expired',
      status_code: :unauthorized
    )
  end

  def self.forbidden(message = nil)
    new(
      title: message || 'Ops! You are not authorized to perform this action',
      description: 'Token is not allowed to perform the action',
      status_code: :forbidden
    )
  end

  def self.unprocessable_entity(error = nil)
    new(
      title: 'Ops! Entity could not be processed',
      description: 'Ops! Entity could not be processed',
      reasons: error.is_a?(Hash) ? error : error.messages,
      status_code: :unprocessable_entity
    )
  end
end
