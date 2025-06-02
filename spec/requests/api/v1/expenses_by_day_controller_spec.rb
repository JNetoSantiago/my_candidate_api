require "rails_helper"

RSpec.describe "Api::V1::ExpensesByDayController", type: :request do
  describe "GET /api/v1/expenses_by_day" do
    let(:url) { "/api/v1/expenses_by_day" }

    before do
      create(:expense, issue_date: Date.parse("2023-12-30"), amount: 184)
      create(:expense, issue_date: Date.parse("2024-01-01"), amount: 1261)
      create(:expense, issue_date: Date.parse("2024-01-01"), amount: 1400)
      create(:expense, issue_date: Date.parse("2024-01-02"), amount: 1412)
    end

    it "returns status 200" do
      get url
      expect(response).to have_http_status(:ok)
    end

    it "returns expenses grouped by day with totals in reais" do
      get url
      json = JSON.parse(response.body)

      expect(json).to contain_exactly(
        { "date" => "2023-12-30", "total" => 1.84 },
        { "date" => "2024-01-01", "total" => 26.61 },
        { "date" => "2024-01-02", "total" => 14.12 }
      )
    end
  end
end
