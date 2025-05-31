module Api
  module V1
    class CsvUploadController < ApplicationController
      def handler
        if params[:file].present?
          tmp_path = Rails.root.join("tmp", "csv_#{SecureRandom.uuid}.csv")
          File.open(tmp_path, "wb") { |f| f.write(params[:file].read) }

          CsvUploadJob.perform_later(tmp_path.to_s)

          render json: { message: "Arquivo CSV está sendo processado!" }, status: :ok
        else
          render json: { error: "É necessário informar um arquivo CSV!" }, status: :unprocessable_entity
        end
      end
    end
  end
end
