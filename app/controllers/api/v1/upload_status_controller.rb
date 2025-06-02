module Api
  module V1
    class UploadStatusController < ApplicationController
      def handler
        upload = CsvUpload.find_by(upload_id: params[:upload_id])

        if upload.nil?
          render json: { error: "Upload not found" }, status: :not_found
        else
          render json: {
            status: upload.status,
            progress: upload.total_rows&.positive? ? (100 * upload.processed_rows / upload.total_rows) : 0,
            processed_rows: upload.processed_rows,
            total_rows: upload.total_rows,
            error_message: upload.error_message
          }
        end
      end
    end
  end
end
