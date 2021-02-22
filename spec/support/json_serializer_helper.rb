# frozen_string_literal: true

module JsonSerializerHelper
  def serialized_json(serializer)
    JSON.parse(serializer.to_json)
  end
end
