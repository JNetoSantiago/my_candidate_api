module Api
  module V1
    module Politicians
      class ShowController < ApplicationController
        def handler
          politician = Politician.find_by(id: params[:id])

          if politician.present?
            paginated_expenses = politician.expenses.order(amount: :desc).page(params[:page]).per(params[:per_page] || 10)

            render json: PoliticianShowSerializer.new(
              politician,
              include: [ :expenses ],
              params: { expenses: paginated_expenses }
            ).serializable_hash.merge(
              meta: {
                current_page: paginated_expenses.current_page,
                total_pages: paginated_expenses.total_pages,
                total_count: paginated_expenses.total_count
              }
            ).to_json, status: :ok
          else
            render json: { error: "Político não encontrado!" }, status: :not_found
          end
        end
      end
    end
  end
end
