# frozen_string_literal: true

module Api
  module V1
    class PropertiesController < Api::V1Controller
      before_action :set_property, only: %i[show update destroy]

      def index
        render json: Property.all, status: :ok
      end

      def show
        render json: property, status: :ok
      end

      def create
        operation = Properties::Operations::Create.new(
          params: property_params
        )
        if operation.run
          render json: operation.property, status: :ok
        else
          response_error_json_format(ErrorResponse.record_not_saved(operation.property))
        end
      end

      def update
        operation = Properties::Operations::UpdateStatus.new(
          property: property, new_status: property_params[:status]
        )
        if operation.run
          render json: property.reload, status: :ok
        else
          response_error_json_format(ErrorResponse.record_not_saved(property))
        end
      end

      def destroy
        operation = Properties::Operations::Destroy.new(
          property: property
        )
        if operation.run
          response_success_json_format(SuccessResponse.record_destroyed(operation.property))
        else
          response_error_json_format(ErrorResponse.record_not_destroyed(operation.property))
        end
      end

      private

      attr_reader :property

      def set_property
        @property = Property.find_by(id: params[:id])
        return if property

        response_error_json_format(ErrorResponse.record_not_found(Property))
      end

      def property_params
        params.require(:property).permit(:name, :description, :rental_price, :status, :owner_id)
      end
    end
  end
end
