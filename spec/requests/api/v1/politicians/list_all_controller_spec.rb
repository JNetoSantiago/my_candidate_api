require 'rails_helper'

RSpec.describe Api::V1::Politicians::ListAllController, type: :request do
  describe 'GET /api/v1/politicians' do
    let(:url) { '/api/v1/politicians' }

    before do
      create(:politician, name: 'Maria Silva')
      create(:politician, name: 'João Souza')
      get url
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct number of politicians' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
    end

    it 'returns the correct politician names' do
      json = JSON.parse(response.body)
      names = json.map { |p| p['name'] }
      expect(names).to include('Maria Silva', 'João Souza')
    end
  end
end
