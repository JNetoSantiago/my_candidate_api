require 'rails_helper'

RSpec.describe Api::V1::CsvUploadController, type: :request do
  describe 'POST /api/v1/csv_upload' do
    let(:url) { '/api/v1/csv_upload' }

    context 'when a file is provided' do
      let(:file_path) { Rails.root.join('spec/fixtures/files/politicians_expenses.csv') }
      let(:file) { fixture_file_upload(file_path, 'text/csv') }

      before do
        ActiveJob::Base.queue_adapter = :test
        post url, params: { file: file }
      end

      it 'enqueues the job' do
        expect(enqueued_jobs.last[:job]).to eq(CsvUploadJob)
      end

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message in JSON' do
        expect(JSON.parse(response.body)).to eq(
          'message' => 'Arquivo CSV está sendo processado!'
        )
      end
    end

    context 'when no file is provided' do
      before { post url }

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message in JSON' do
        expect(JSON.parse(response.body)).to eq(
          'error' => 'É necessário informar um arquivo CSV!'
        )
      end
    end
  end
end
