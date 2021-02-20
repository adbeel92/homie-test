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

      # def create
      # end

      # def update
      # end

      # def destroy
      # end

      private

      attr_reader :property

      def set_property
        @property = Property.find_by(id: params[:id])
        return if property

        response_error_json_format(ErrorResponse.record_not_found(Property))
      end

      # def property_params
      #   params.require(:property).permit(:name, :description, :rental_price, :status, :owner)
      # end
    end
  end
end
