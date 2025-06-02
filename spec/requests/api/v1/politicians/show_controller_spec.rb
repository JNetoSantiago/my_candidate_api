require 'rails_helper'

RSpec.describe "Api::V1::Politicians::ShowController", type: :request do
  describe "GET /api/v1/politicians/:id" do
    let(:politician) do
      create(:politician,
        name: "Julio Arcoverde",
        cpf: "77309766768",
        external_id: 66385,
        state: "PI",
        party: "PP",
        photo_url: nil
      )
    end

    let!(:expenses) do
      create_list(:expense, 3, politician: politician, amount: 100.0, supplier_name: "TAM", description: "PASSAGEM AÉREA - SIGEPA")
    end

    context "when the politician exists" do
      before { get "/api/v1/politicians/#{politician.id}" }

      let(:json) { JSON.parse(response.body) }

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct politician ID" do
        expect(json["data"]["id"]).to eq(politician.id.to_s)
      end

      it "returns the correct name" do
        expect(json["data"]["attributes"]["name"]).to eq("Julio Arcoverde")
      end

      it "returns included expenses" do
        expect(json["included"].size).to eq(3)
      end
    end

    context "when the politician does not exist" do
      before { get "/api/v1/politicians/999999" }

      it "returns 404 status" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns an error message" do
        expect(JSON.parse(response.body)).to eq("error" => "Político não encontrado!")
      end
    end
  end
end
