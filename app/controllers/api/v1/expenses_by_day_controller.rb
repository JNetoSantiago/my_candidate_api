module Api
  module V1
    class ExpensesByDayController < ApplicationController
      def handler
        data = Expense
          .group("DATE(issue_date)")
          .select("DATE(issue_date) as date, SUM(amount) as total")
          .order("date")
          .map do |record|
            {
              date: record.date,
              total: (record.total.to_f / 100).round(2)
            }
          end

        render json: data
      end
    end
  end
end
