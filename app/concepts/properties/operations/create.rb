# frozen_string_literal: true

module Properties
  module Operations
    class Create
      attr_reader :property, :params

      def initialize(params:)
        @property = Property.new
        @params = params
      end

      def run
        return unless valid?

        property.save
      end

      def valid?
        valid_status? && valid_instance?
      end

      def valid_instance?
        property.assign_attributes(params)
        property.valid?
      end

      def valid_status?
        return true if Property.statuses.keys.include?(params[:status])

        property.errors.add(:status, 'is already that status')
        false
      end
    end
  end
end
