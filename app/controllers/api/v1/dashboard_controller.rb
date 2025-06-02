module Api
  module V1
    class DashboardController < ApplicationController
      def handler
        result = DashboardStats.new.call

        case result
        when Dry::Monads::Success
          render json: result.value!
        when Dry::Monads::Failure
          render json: { error: result.failure }, status: :internal_server_error
        end
      end
    end
  end
end
