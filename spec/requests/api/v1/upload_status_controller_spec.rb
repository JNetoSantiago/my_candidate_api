require "rails_helper"

RSpec.describe "Api::V1::UploadStatusController", type: :request do
  describe "GET /api/v1/upload_status/:id" do
    let(:upload_id) { SecureRandom.uuid                     }
    let(:url)       { "/api/v1/upload_status/#{upload_id}"  }

    context "when the upload exists" do
      let!(:csv_upload) do
        CsvUpload.create!(
          upload_id: upload_id,
          status: "done",
          processed_rows: 3393,
          total_rows: 3393,
          error_message: nil
        )
      end

      before { get url }

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns correct upload status info" do
        json = JSON.parse(response.body)

        expect(json).to include("status" => "done", "progress" => 100, "processed_rows" => 3393, "total_rows" => 3393, "error_message" => nil)
      end
    end

    context "when the upload does not exist" do
      before { get "/api/v1/upload_status/nonexistent" }

      it "returns 500 with error" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns appropriate error message" do
        expected_response = { "error" => "Upload not found" }.to_json
        expect(response.body).to eq(expected_response)
      end
    end
  end
end
