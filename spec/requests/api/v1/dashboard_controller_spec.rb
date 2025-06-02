require "rails_helper"

RSpec.describe "Api::V1::DashboardController", type: :request do
  describe "GET /api/v1/dashboard_stats" do
    let(:url) { "/api/v1/dashboard_stats" }

    context "when the service returns success" do
      let(:politician) { create(:politician, name: "Merlong Solano", party: "PT", state: "PI") }
      let!(:expense) do
        create(:expense, amount: 30000, politician: politician, description: "DIVULGAÇÃO DA ATIVIDADE PARLAMENTAR.")
      end

      before { get url }

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct dashboard data" do
        json = JSON.parse(response.body)

        expect(json["total_politicians"]).to eq(1)
        expect(json["total_expenses"]).to eq(1)
        expect(json["total_amount"]).to eq("R$ 300,00")

        expect(json["max_expense"]).to include(
          "amount" => "R$ 300,00",
          "description" => "DIVULGAÇÃO DA ATIVIDADE PARLAMENTAR.",
          "politician" => {
            "name" => "Merlong Solano",
            "party" => "PT",
            "state" => "PI"
          }
        )
      end
    end

    context "when the service returns failure" do
      before do
        failure = Dry::Monads::Failure("something went wrong")
        allow_any_instance_of(DashboardStats).to receive(:call).and_return(failure)
        get url
      end

      it "returns status 500" do
        expect(response).to have_http_status(:internal_server_error)
      end

      it "returns error message" do
        json = JSON.parse(response.body)
        expect(json).to include("error" => "something went wrong")
      end
    end
  end
end
