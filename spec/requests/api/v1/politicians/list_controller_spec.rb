require 'rails_helper'

RSpec.describe Api::V1::Politicians::ListController, type: :request do
  describe 'GET /api/v1/politicians' do
    let(:url) { '/api/v1/politicians' }

    let!(:maria_silva) do
      create(:politician,
        name: 'Maria Silva',
        cpf: '11111111111',
        external_id: 1,
        state: 'PI',
        party: 'PT'
      )
    end

    let!(:joao_souza) do
      create(:politician,
        name: 'João Souza',
        cpf: '22222222222',
        external_id: 2,
        state: 'PI',
        party: 'PP'
      )
    end

    let(:json) { JSON.parse(response.body) }
    let(:data) { json['data'] }

    before { get url }

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct number of politicians' do
      expect(data.count).to eq(2)
    end

    it 'returns the correct names in the attributes' do
      names = data.map { |p| p['attributes']['name'] }
      expect(names).to include('Maria Silva', 'João Souza')
    end

    it 'has type "politician" for each entry' do
      data.each do |politician|
        expect(politician['type']).to eq('politician')
      end
    end

    it 'has id present for each entry' do
      data.each do |politician|
        expect(politician['id']).to be_present
      end
    end

    it 'includes expected attribute keys' do
      data.each do |politician|
        expect(politician['attributes'].keys).to include('name', 'cpf', 'external_id', 'state', 'party', 'photo_url', 'politician_image_url')
      end
    end
  end
end
