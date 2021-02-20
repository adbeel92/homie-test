# frozen_string_literal: true

module RequestsHelper
  def parsed_response
    @parsed_response ||= JSON.parse(response.body)
  end

  def generate_token
    allow_any_instance_of(Api::V1Controller).to receive(:authorized!).and_return(true)
  end
end
