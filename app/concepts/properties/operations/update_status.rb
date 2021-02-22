# frozen_string_literal: true

module Properties
  module Operations
    class UpdateStatus
      def initialize(property:, new_status:)
        @property = property
        @new_status = new_status
      end

      def run
        return unless valid?

        property.update(status: new_status)
      end

      def valid?
        valid_attributes? && valid_status?
      end

      private

      attr_reader :property, :new_status

      def valid_attributes?
        return true if property.is_a?(Property) && Property.statuses.keys.include?(new_status)

        property.errors.add(:base, 'invalid parameters')
        false
      end

      def valid_status?
        return true unless property.status == new_status

        property.errors.add(:status, 'is already that status')
        false
      end
    end
  end
end
