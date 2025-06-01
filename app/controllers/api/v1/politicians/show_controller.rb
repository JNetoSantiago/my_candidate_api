module Api
  module V1
    module Politicians
      class ShowController < ApplicationController
        def handler
          politician = Politician.includes(:expenses).find_by(id: params[:id])

          if politician.present?
            render json: PoliticianShowSerializer.new(politician, include: [ :expenses ]).serializable_hash.to_json, status: :ok
          else
            render json: { error: "Político não encontrado!" }, status: :not_found
          end
        end
      end
    end
  end
end
