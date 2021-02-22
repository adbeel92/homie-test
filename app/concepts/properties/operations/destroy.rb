# frozen_string_literal: true

module Properties
  module Operations
    class Destroy
      attr_reader :property

      def initialize(property:)
        @property = property
      end

      def run
        property.destroy
      end
    end
  end
end
