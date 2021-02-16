# frozen_string_literal: true

class SuccessResponse
  attr_reader :title, :description, :status_code

  def initialize(args)
    @title = args[:title]
    @description = args[:description]
    @status_code = args[:status_code]
  end

  def to_json(*_args)
    {
      success: true,
      response: {
        message: title,
        description: description
      }
    }
  end

  def self.record_destroyed(record)
    new(
      title: "#{record.class.model_name.human} removido",
      description: "#{record.class.model_name.human} ##{record.id} ha sido eliminado con éxito",
      status_code: :ok
    )
  end
end
