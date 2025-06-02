require 'rails_helper'

RSpec.describe Api::V1::CsvUploadController, type: :request do
  include ActiveJob::TestHelper

  describe 'POST /api/v1/csv_upload' do
    let(:url) { '/api/v1/csv_upload' }

    context 'when a file is provided' do
      let(:file_path) { Rails.root.join('spec/fixtures/files/politicians_expenses.csv') }
      let(:file) { fixture_file_upload(file_path, 'text/csv') }

      before do
        ActiveJob::Base.queue_adapter = :test
        clear_enqueued_jobs
        clear_performed_jobs

        post url, params: { file: file }
      end

      it 'enqueues CsvUploadJob' do
        expect(enqueued_jobs.map { |j| j[:job] }).to include(CsvUploadJob)
      end

      it 'creates a CsvUpload record' do
        expect(CsvUpload.count).to eq(1)
      end

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success message' do
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Arquivo CSV está sendo processado!')
      end

      it 'returns the upload_id' do
        json = JSON.parse(response.body)
        expect(json['upload_id']).to be_present
      end
    end

    context 'when no file is provided' do
      before do
        ActiveJob::Base.queue_adapter = :test
        clear_enqueued_jobs
        post url
      end

      it 'does not enqueue any job or create record' do
        expect(enqueued_jobs).to be_empty
      end

      it 'does not create CsvUpload register' do
        expect(CsvUpload.count).to eq(0)
      end

      it 'returns error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        expect(JSON.parse(response.body)).to eq(
          'error' => 'É necessário informar um arquivo CSV!'
        )
      end
    end
  end
end
