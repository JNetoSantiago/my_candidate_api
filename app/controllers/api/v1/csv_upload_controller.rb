module Api
  module V1
    class CsvUploadController < ApplicationController
      STATE = "PI".freeze

      def handler
        if params[:file].present?
          upload_id = SecureRandom.uuid

          upload = CsvUpload.create!(upload_id:, state: STATE, status: :queued)

          tmp_path = Rails.root.join("tmp", "csv_#{SecureRandom.uuid}.csv")
          File.open(tmp_path, "wb") { |f| f.write(params[:file].read) }

          CsvUploadJob.perform_later(tmp_path.to_s, upload.id)

          render json: { message: "Arquivo CSV está sendo processado!", upload_id: upload_id }, status: :ok
        else
          render json: { error: "É necessário informar um arquivo CSV!" }, status: :unprocessable_entity
        end
      end
    end
  end
end
